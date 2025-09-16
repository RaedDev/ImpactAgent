-- Team: Sara & Ziad & Romaysa
WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Sara & Ziad & Romaysa') RETURNING id
)
INSERT INTO members (team_id, full_name) 
SELECT id, member_name FROM team_insert, 
(VALUES ('Sara'), ('Ziad'), ('Romaysa')) AS members(member_name);

WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Sara & Ziad & Romaysa') RETURNING id
)
INSERT INTO projects (team_id, name, slug, mission, problem, stage, published)
SELECT id,
   'Spanish Muslim Student Transition',
   'spanish-muslim-student-transition',
   'Helping Spanish Muslim students transition from high school to university and workplace while staying true to Islamic values',
   'Muslim students struggle with belonging and values when moving from high school to university or work; some drop out or isolate themselves',
   'idea',
   true
FROM team_insert;

-- Team: Sara (Haitham)
WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Sara (Haitham)') RETURNING id
)
INSERT INTO members (team_id, full_name) 
SELECT id, 'Sara Haitham' FROM team_insert;

WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Sara (Haitham)') RETURNING id
)
INSERT INTO projects (team_id, name, slug, mission, problem, stage, published)
SELECT id,
   'Volunteer Matching Platform',
   'volunteer-matching-platform',
   'Linking volunteers based on shared values; inspired by Nahda Al Shababiah initiative in Syria',
   'Lack of structure in linking and engaging values-driven volunteers effectively',
   'planning',
   true
FROM team_insert;

-- Team: Ebaa & Rama
WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Ebaa & Rama') RETURNING id
)
INSERT INTO members (team_id, full_name) 
SELECT id, member_name FROM team_insert, 
(VALUES ('Ebaa'), ('Rama')) AS members(member_name);

WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Ebaa & Rama') RETURNING id
)
INSERT INTO projects (team_id, name, slug, mission, problem, stage, published)
SELECT id,
   'Work Therapy for Refugees',
   'work-therapy-for-refugees',
   'Training refugees on profitable handcraft skills while incorporating mindfulness',
   'Refugees in camps suffer from joblessness despite having access to psychologists',
   'development',
   true
FROM team_insert;

-- Team: Ammar
WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Ammar') RETURNING id
)
INSERT INTO members (team_id, full_name) 
SELECT id, 'Ammar' FROM team_insert;

WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Ammar') RETURNING id
)
INSERT INTO projects (team_id, name, slug, mission, problem, stage, published)
SELECT id,
   'Sharia-Compliant Business Community',
   'sharia-compliant-business-community',
   'Building a community of Muslim entrepreneurs to transact under Quran and Sunnah guidelines',
   'Muslim entrepreneurs need an economic space that preserves, grows, and circulates wealth while being Sharia-compliant',
   'pilot',
   true
FROM team_insert;

-- Team: Meriam
WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Meriam') RETURNING id
)
INSERT INTO members (team_id, full_name) 
SELECT id, 'Meriam' FROM team_insert;

WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Meriam') RETURNING id
)
INSERT INTO projects (team_id, name, slug, mission, problem, stage, published)
SELECT id,
   'Youth Mental Health Awareness',
   'youth-mental-health-awareness',
   'Raising mental health awareness within the scouts community, targeting teenagers',
   'Teenagers in scouts community lack awareness and access to mental health support',
   'scaling',
   true
FROM team_insert;

-- Team: Rehema
WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Rehema') RETURNING id
)
INSERT INTO members (team_id, full_name) 
SELECT id, 'Rehema' FROM team_insert;

WITH team_insert AS (
  INSERT INTO teams (name) VALUES ('Rehema') RETURNING id
)
INSERT INTO projects (team_id, name, slug, mission, problem, stage, published)
SELECT id,
   'Mental Health Social Media Platform',
   'mental-health-social-media-platform',
   'Breaking stigma by sharing accessible content (posts, podcasts, animations) and later building therapist matching system',
   'Educated Muslim youth lack access to culturally aware mental health professionals due to stigma and scarcity of Muslim therapists',
   'established',
   true
FROM team_insert;
