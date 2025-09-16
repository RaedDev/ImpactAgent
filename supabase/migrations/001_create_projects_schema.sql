-- Impact Agent Database Schema
-- This migration creates the core schema for team-based project management
-- 
-- Schema Overview:
-- - Teams: Top-level organizational units
-- - Projects: Belong to teams, represent specific initiatives
-- - Members: Can belong to teams and optionally be assigned to specific projects
-- - RLS policies ensure users only see data for teams they belong to

-- Drop existing tables
drop table if exists members cascade;
drop table if exists projects cascade;
drop table if exists teams cascade;

-- Enable RLS globally
alter database postgres set row_security = on;

-- Teams table (must be created first due to foreign key dependencies)
create table teams (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamp default now()
);

-- Projects table
create table projects (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references teams(id) on delete cascade,
  owner_id uuid references auth.users(id) on delete cascade,
  name text not null,
  slug text unique,
  mission text,
  problem text, -- the "problem / reason this project exists" (renamed from 'why')
  beneficiaries text,
  geography text,
  sector_tags text[], -- array of sector tags
  stage text check (stage in ('idea', 'planning', 'development', 'pilot', 'scaling', 'established')),
  needs text[], -- array of project needs
  languages text[], -- array of supported languages
  links text[], -- array of project links
  contact_email text check (contact_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
  published boolean default false,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

-- Members table - now connected to both team AND project
create table members (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references teams(id) on delete cascade,
  project_id uuid references projects(id) on delete cascade,
  full_name text not null,
  email text unique check (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
  user_id uuid references auth.users(id) on delete cascade, -- supabase auth
  role text default 'member' check (role in ('owner', 'admin', 'member')),
  created_at timestamp default now()
);

-- Performance indexes for frequently queried columns
create index idx_members_user_id on members(user_id);
create index idx_members_team_id on members(team_id);
create index idx_members_project_id on members(project_id);
create index idx_projects_team_id on projects(team_id);
create index idx_projects_owner_id on projects(owner_id);
create index idx_projects_slug on projects(slug);
create index idx_projects_published on projects(published);
create index idx_projects_stage on projects(stage);
create index idx_projects_sector_tags on projects using gin(sector_tags);
create index idx_projects_created_at on projects(created_at);
create index idx_projects_updated_at on projects(updated_at);

-- Data consistency trigger function
-- Ensures that if a member is assigned to a project, their team_id matches the project's team_id
create or replace function check_member_team_consistency()
returns trigger as $$
begin
  -- If project_id is provided, ensure its team_id matches the member.team_id
  if NEW.project_id is not null then
    if NEW.team_id is distinct from (select team_id from projects where id = NEW.project_id) then
      raise exception 'Member team_id must match the project''s team_id';
    end if;
  end if;
  return NEW;
end;
$$ language plpgsql;

-- Trigger function to automatically update updated_at timestamp
create or replace function update_updated_at_column()
returns trigger as $$
begin
  NEW.updated_at = now();
  return NEW;
end;
$$ language plpgsql;

-- Function to generate slug from project name
create or replace function generate_slug(input_text text)
returns text as $$
begin
  return lower(
    regexp_replace(
      regexp_replace(
        regexp_replace(trim(input_text), '[^a-zA-Z0-9\s]', '', 'g'),
        '\s+', '-', 'g'
      ),
      '-+', '-', 'g'
    )
  );
end;
$$ language plpgsql;

-- Function to ensure unique slug
create or replace function generate_unique_slug(project_name text, project_id uuid default null)
returns text as $$
declare
  base_slug text;
  final_slug text;
  counter int := 1;
begin
  base_slug := generate_slug(project_name);
  final_slug := base_slug;
  
  -- Check if slug exists (excluding current project if updating)
  while exists (
    select 1 from projects 
    where slug = final_slug 
    and (project_id is null or id != project_id)
  ) loop
    final_slug := base_slug || '-' || counter;
    counter := counter + 1;
  end loop;
  
  return final_slug;
end;
$$ language plpgsql;

-- Trigger function to automatically generate slug from name
create or replace function auto_generate_slug()
returns trigger as $$
begin
  -- Only generate slug if it's not provided or if name changed
  if NEW.slug is null or (TG_OP = 'UPDATE' and OLD.name != NEW.name and NEW.slug = OLD.slug) then
    NEW.slug := generate_unique_slug(NEW.name, NEW.id);
  end if;
  return NEW;
end;
$$ language plpgsql;

-- Create the triggers
create trigger member_team_consistency_trigger
  before insert or update on members
  for each row
  execute function check_member_team_consistency();

create trigger projects_slug_trigger
  before insert or update on projects
  for each row
  execute function auto_generate_slug();

create trigger projects_updated_at_trigger
  before update on projects
  for each row
  execute function update_updated_at_column();

-- Enable RLS on all tables
alter table teams enable row level security;
alter table projects enable row level security;
alter table members enable row level security;

-- RLS Policies for Members (must come first to avoid circular dependencies)
create policy "Users can view their own member record" on members
  for select using (user_id = auth.uid());

create policy "Users can update their own member info" on members
  for update using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- Allow authenticated users to insert members (team creation scenario)
create policy "Authenticated users can insert members" on members
  for insert with check (auth.role() = 'authenticated');

-- RLS Policies for Teams
create policy "Users can view teams they belong to" on teams
  for select using (
    id in (
      select team_id from members 
      where user_id = auth.uid()
    )
  );

create policy "Team owners can update teams" on teams
  for update using (
    id in (
      select team_id from members 
      where user_id = auth.uid() and role in ('owner', 'admin')
    )
  );

create policy "Authenticated users can create teams" on teams
  for insert with check (auth.role() = 'authenticated');

-- RLS Policies for Projects
create policy "Users can view projects they belong to" on projects
  for select using (
    team_id in (
      select team_id from members 
      where user_id = auth.uid()
    )
  );

create policy "Users can view published projects" on projects
  for select using (published = true);

create policy "Project owners can view their projects" on projects
  for select using (owner_id = auth.uid());

create policy "Team owners/admins can manage projects" on projects
  for all using (
    team_id in (
      select team_id from members 
      where user_id = auth.uid() and role in ('owner', 'admin')
    )
  );

create policy "Project owners can manage their projects" on projects
  for all using (owner_id = auth.uid());