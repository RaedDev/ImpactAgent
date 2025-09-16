-- Team: Sara & Ziad & Romaysa
insert into teams (name) values ('Sara & Ziad & Romaysa') returning id \gset
insert into members (team_id, full_name) values
  (:'id', 'Sara'),
  (:'id', 'Ziad'),
  (:'id', 'Romaysa');

insert into projects (team_id, name, description, why) values
  (:'id',
   'Spanish Muslim Student Transition',
   'Helping Spanish Muslim students transition from high school to university and workplace while staying true to Islamic values',
   'Muslim students struggle with belonging and values when moving from high school to university or work; some drop out or isolate themselves');

-- Team: Sara (Haitham)
insert into teams (name) values ('Sara (Haitham)') returning id \gset
insert into members (team_id, full_name) values
  (:'id', 'Sara Haitham');

insert into projects (team_id, name, description, why) values
  (:'id',
   'Volunteer Matching Platform',
   'Linking volunteers based on shared values; inspired by Nahda Al Shababiah initiative in Syria',
   'Lack of structure in linking and engaging values-driven volunteers effectively');

-- Team: Ebaa & Rama
insert into teams (name) values ('Ebaa & Rama') returning id \gset
insert into members (team_id, full_name) values
  (:'id', 'Ebaa'),
  (:'id', 'Rama');

insert into projects (team_id, name, description, why) values
  (:'id',
   'Work Therapy for Refugees',
   'Training refugees on profitable handcraft skills while incorporating mindfulness',
   'Refugees in camps suffer from joblessness despite having access to psychologists');

-- Team: Ammar
insert into teams (name) values ('Ammar') returning id \gset
insert into members (team_id, full_name) values
  (:'id', 'Ammar');

insert into projects (team_id, name, description, why) values
  (:'id',
   'Sharia-Compliant Business Community',
   'Building a community of Muslim entrepreneurs to transact under Quran and Sunnah guidelines',
   'Muslim entrepreneurs need an economic space that preserves, grows, and circulates wealth while being Sharia-compliant');

-- Team: Meriam
insert into teams (name) values ('Meriam') returning id \gset
insert into members (team_id, full_name) values
  (:'id', 'Meriam');

insert into projects (team_id, name, description, why) values
  (:'id',
   'Youth Mental Health Awareness',
   'Raising mental health awareness within the scouts community, targeting teenagers',
   'Teenagers in scouts community lack awareness and access to mental health support');

-- Team: Rehema
insert into teams (name) values ('Rehema') returning id \gset
insert into members (team_id, full_name) values
  (:'id', 'Rehema');

insert into projects (team_id, name, description, why) values
  (:'id',
   'Mental Health Social Media Platform',
   'Breaking stigma by sharing accessible content (posts, podcasts, animations) and later building therapist matching system',
   'Educated Muslim youth lack access to culturally aware mental health professionals due to stigma and scarcity of Muslim therapists');
