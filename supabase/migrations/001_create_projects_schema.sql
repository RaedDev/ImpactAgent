-- Teams
create table teams (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamp default now()
);

-- Members
create table members (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references teams(id) on delete cascade,
  full_name text not null,
  created_at timestamp default now()
);

-- Projects
create table projects (
  id uuid primary key default gen_random_uuid(),
  team_id uuid references teams(id) on delete cascade,
  name text not null,
  description text,
  why text, -- the "problem / reason this project exists"
  created_at timestamp default now()
);
