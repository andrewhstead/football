#Syntax used to create the database

CREATE DATABASE football;

use football;

CREATE TABLE clubs (
    id INTEGER auto_increment,
    club_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO clubs (
	club_name
) VALUES
	('Accrington'),
    ('Aston Villa'),
    ('Blackburn Rovers'),
    ('Bolton Wanderers'),
    ('Burnley'),
    ('Derby County'),
    ('Everton'),
    ('Notts County'),
    ('Preston North End'),
    ('Stoke City'),
    ('West Bromwich Albion'),
    ('Wolverhampton Wanderers')
;

CREATE TABLE teams (
    id INTEGER auto_increment,
    team_name VARCHAR(50) NOT NULL,
    club_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (club_id) REFERENCES clubs(id)
);

INSERT INTO teams (
	team_name,
    club_id
) VALUES
	('Accrington', 1),
    ('Aston Villa', 2),
    ('Blackburn Rovers', 3),
    ('Bolton Wanderers', 4),
    ('Burnley', 5),
    ('Derby County', 6),
    ('Everton', 7),
    ('Notts County', 8),
    ('Preston North End', 9),
    ('Stoke', 10),
    ('West Bromwich Albion', 11),
    ('Wolverhampton Wanderers', 12)
;

CREATE TABLE seasons (
    id INTEGER auto_increment,
    season VARCHAR(10) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO seasons (
	season
) VALUES
	('1888-89')
;

CREATE TABLE divisions (
    id INTEGER auto_increment,
    division VARCHAR(50) NOT NULL,
    abbreviation VARCHAR(5) NOT NULL,
    tier INT NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO divisions (
	division,
    abbreviation,
    tier
) VALUES
	('Football League', 'FL', 1)
;

CREATE INDEX team_index ON teams (team_name);
CREATE INDEX season_index ON seasons (season);
CREATE INDEX division_index ON divisions (abbreviation);

CREATE TABLE results (
    id INTEGER auto_increment,
    game_date DATE NOT NULL,
    home_team VARCHAR(50) NOT NULL,
    home_score INT NOT NULL,
    away_score INT NOT NULL,
    away_team VARCHAR(50) NOT NULL,
    season VARCHAR(10) NOT NULL,
    division VARCHAR(5) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (home_team) REFERENCES teams(team_name),
    FOREIGN KEY (away_team) REFERENCES teams(team_name),
    FOREIGN KEY (season) REFERENCES seasons(season),
    FOREIGN KEY (division) REFERENCES divisions(abbreviation)
);

INSERT INTO results (
	game_date,
    home_team,
    home_score,
    away_score,
    away_team,
    season,
    division
) VALUES
	('1888-09-08', 'Bolton Wanderers', 3, 6, 'Derby County', '1888-89', 'FL'),
    ('1888-09-08', 'Everton', 2, 1, 'Accrington', '1888-89', 'FL'),
    ('1888-09-08', 'Preston North End', 5, 2, 'Burnley', '1888-89', 'FL'),
    ('1888-09-08', 'Stoke', 0, 2, 'West Bromwich Albion', '1888-89', 'FL'),
    ('1888-09-08', 'Wolverhampton Wanderers', 1, 1, 'Aston Villa', '1888-89', 'FL'),
	('1888-09-15', 'Aston Villa', 5, 1, 'Stoke', '1888-89', 'FL'),
    ('1888-09-15', 'Blackburn Rovers', 5, 5, 'Accrington', '1888-89', 'FL'),
    ('1888-09-15', 'Bolton Wanderers', 3, 4, 'Burnley', '1888-89', 'FL'),
    ('1888-09-15', 'Derby County', 1, 2, 'West Bromwich Albion', '1888-89', 'FL'),
    ('1888-09-15', 'Everton', 2, 1, 'Notts County', '1888-89', 'FL'),
    ('1888-09-15', 'Wolverhampton Wanderers', 0, 4, 'Preston North End', '1888-89', 'FL')
;

# To create a league table -
SELECT
	teams.team_name AS Team,
    SUM(if(teams.team_name = results.home_team OR teams.team_name = results.away_team,1,0)) AS P,
    SUM(if(teams.team_name = results.away_team
		AND results.away_score > results.home_score
        OR teams.team_name = results.home_team
        AND results.home_score > results.away_score,1,0))
        AS W,
    SUM(IF(results.away_score = results.home_score,1,0)) AS D,
	SUM(if(teams.team_name = results.away_team
		AND results.away_score < results.home_score
        OR teams.team_name = results.home_team
        AND results.home_score < results.away_score,1,0))
        AS L,
    SUM(IF(teams.team_name = results.home_team,results.home_score,0))
	+ SUM(IF(teams.team_name = results.away_team,results.away_score,0))
        AS F,
    SUM(IF(teams.team_name = results.home_team,results.away_score,0))
	+ SUM(IF(teams.team_name = results.away_team,results.home_score,0))
        AS A,
	ROUND((SUM(IF(teams.team_name = results.home_team,results.home_score,0)) + SUM(IF(teams.team_name = results.away_team,results.away_score,0))) / (SUM(IF(teams.team_name = results.home_team,results.away_score,0)) + SUM(IF(teams.team_name = results.away_team,results.home_score,0))),3)
		AS GA,
    SUM(if(teams.team_name = results.away_team
		AND results.away_score > results.home_score
        OR teams.team_name = results.home_team
        AND results.home_score > results.away_score,2,0))
    + SUM(IF(results.away_score = results.home_score,1,0))
		AS Pts
FROM teams
INNER JOIN results ON teams.team_name = results.home_team 
    OR teams.team_name = results.away_team
GROUP BY teams.team_name
ORDER BY Pts DESC, GA DESC, Team ASC;
