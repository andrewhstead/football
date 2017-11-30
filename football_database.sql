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

CREATE INDEX team_index ON teams (team_name);

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

CREATE INDEX season_index ON seasons (season);

INSERT INTO seasons (
	season
) VALUES
	('1888-89'),
	('1889-90')
;

CREATE TABLE divisions (
    id INTEGER auto_increment,
    division VARCHAR(50) NOT NULL,
    abbreviation VARCHAR(5) NOT NULL,
    tier INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE INDEX division_index ON divisions (abbreviation);

INSERT INTO divisions (
	division,
    abbreviation,
    tier
) VALUES
	('Football League', 'FL', 1)
;

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

CREATE INDEX home_team_index ON results (home_team);
CREATE INDEX away_team_index ON results (away_team);

INSERT INTO results (
	game_date,
    home_team,
    home_score,
    away_score,
    away_team,
    season,
    division
) VALUES
('1888-09-08','Bolton Wanderers',3,6,'Derby County','1888-89','FL'),
('1888-09-08','Everton',2,1,'Accrington','1888-89','FL'),
('1888-09-08','Preston North End',5,2,'Burnley','1888-89','FL'),
('1888-09-08','Stoke',0,2,'West Bromwich Albion','1888-89','FL'),
('1888-09-08','Wolverhampton Wanderers',1,1,'Aston Villa','1888-89','FL'),
('1888-09-15','Aston Villa',5,1,'Stoke','1888-89','FL'),
('1888-09-15','Blackburn Rovers',5,5,'Accrington','1888-89','FL'),
('1888-09-15','Bolton Wanderers',3,4,'Burnley','1888-89','FL'),
('1888-09-15','Derby County',1,2,'West Bromwich Albion','1888-89','FL'),
('1888-09-15','Everton',2,1,'Notts County','1888-89','FL'),
('1888-09-15','Wolverhampton Wanderers',0,4,'Preston North End','1888-89','FL'),
('1888-09-22','Aston Villa',2,1,'Everton','1888-89','FL'),
('1888-09-22','Blackburn Rovers',6,2,'West Bromwich Albion','1888-89','FL'),
('1888-09-22','Derby County',1,1,'Accrington','1888-89','FL'),
('1888-09-22','Preston North End',3,1,'Bolton Wanderers','1888-89','FL'),
('1888-09-22','Stoke',3,0,'Notts County','1888-89','FL'),
('1888-09-22','Wolverhampton Wanderers',4,1,'Burnley','1888-89','FL'),
('1888-09-29','Aston Villa',9,1,'Notts County','1888-89','FL'),
('1888-09-29','Bolton Wanderers',6,2,'Everton','1888-89','FL'),
('1888-09-29','Derby County',2,3,'Preston North End','1888-89','FL'),
('1888-09-29','Stoke',2,4,'Accrington','1888-89','FL'),
('1888-09-29','West Bromwich Albion',4,3,'Burnley','1888-89','FL'),
('1888-09-29','Wolverhampton Wanderers',2,2,'Blackburn Rovers','1888-89','FL'),
('1888-10-06','Accrington',4,4,'Wolverhampton Wanderers','1888-89','FL'),
('1888-10-06','Burnley',4,1,'Bolton Wanderers','1888-89','FL'),
('1888-10-06','Everton',2,0,'Aston Villa','1888-89','FL'),
('1888-10-06','Notts County',3,3,'Blackburn Rovers','1888-89','FL'),
('1888-10-06','Preston North End',7,0,'Stoke','1888-89','FL'),
('1888-10-06','West Bromwich Albion',5,0,'Derby County','1888-89','FL'),
('1888-10-13','Accrington',6,2,'Derby County','1888-89','FL'),
('1888-10-13','Aston Villa',6,1,'Blackburn Rovers','1888-89','FL'),
('1888-10-13','Bolton Wanderers',2,1,'Stoke','1888-89','FL'),
('1888-10-13','Burnley',0,4,'Wolverhampton Wanderers','1888-89','FL'),
('1888-10-13','Notts County',3,1,'Everton','1888-89','FL'),
('1888-10-13','Preston North End',3,0,'West Bromwich Albion','1888-89','FL'),
('1888-10-20','Accrington',0,0,'Preston North End','1888-89','FL'),
('1888-10-20','Blackburn Rovers',2,2,'Wolverhampton Wanderers','1888-89','FL'),
('1888-10-20','Bolton Wanderers',2,3,'Aston Villa','1888-89','FL'),
('1888-10-20','Derby County',2,4,'Everton','1888-89','FL'),
('1888-10-20','Stoke',4,3,'Burnley','1888-89','FL'),
('1888-10-20','West Bromwich Albion',4,2,'Notts County','1888-89','FL'),
('1888-10-27','Aston Villa',4,3,'Accrington','1888-89','FL'),
('1888-10-27','Blackburn Rovers',5,2,'Stoke','1888-89','FL'),
('1888-10-27','Everton',6,2,'Derby County','1888-89','FL'),
('1888-10-27','Notts County',6,1,'Burnley','1888-89','FL'),
('1888-10-27','Preston North End',5,2,'Wolverhampton Wanderers','1888-89','FL'),
('1888-11-03','Burnley',1,7,'Blackburn Rovers','1888-89','FL'),
('1888-11-03','Everton',2,1,'Bolton Wanderers','1888-89','FL'),
('1888-11-03','Notts County',0,7,'Preston North End','1888-89','FL'),
('1888-11-03','Stoke',1,1,'Aston Villa','1888-89','FL'),
('1888-11-03','West Bromwich Albion',2,2,'Accrington','1888-89','FL'),
('1888-11-03','Wolverhampton Wanderers',4,1,'Derby County','1888-89','FL'),
('1888-11-05','West Bromwich Albion',1,5,'Bolton Wanderers','1888-89','FL'),
('1888-11-10','Blackburn Rovers',3,0,'Everton','1888-89','FL'),
('1888-11-10','Burnley',2,0,'West Bromwich Albion','1888-89','FL'),
('1888-11-10','Notts County',3,3,'Accrington','1888-89','FL'),
('1888-11-10','Preston North End',1,1,'Aston Villa','1888-89','FL'),
('1888-11-10','Wolverhampton Wanderers',3,2,'Bolton Wanderers','1888-89','FL'),
('1888-11-12','Stoke',0,3,'Preston North End','1888-89','FL'),
('1888-11-17','Blackburn Rovers',5,1,'Aston Villa','1888-89','FL'),
('1888-11-17','Bolton Wanderers',1,2,'West Bromwich Albion','1888-89','FL'),
('1888-11-17','Burnley',2,2,'Everton','1888-89','FL'),
('1888-11-17','Preston North End',2,0,'Accrington','1888-89','FL'),
('1888-11-17','Stoke',0,1,'Wolverhampton Wanderers','1888-89','FL'),
('1888-11-24','Accrington',2,1,'West Bromwich Albion','1888-89','FL'),
('1888-11-24','Aston Villa',2,1,'Wolverhampton Wanderers','1888-89','FL'),
('1888-11-24','Bolton Wanderers',2,5,'Preston North End','1888-89','FL'),
('1888-11-24','Derby County',0,2,'Blackburn Rovers','1888-89','FL'),
('1888-11-24','Everton',3,2,'Burnley','1888-89','FL'),
('1888-11-24','Notts County',0,3,'Stoke','1888-89','FL'),
('1888-12-01','Accrington',5,1,'Burnley','1888-89','FL'),
('1888-12-01','Everton',1,4,'West Bromwich Albion','1888-89','FL'),
('1888-12-01','Stoke',2,1,'Blackburn Rovers','1888-89','FL'),
('1888-12-08','Blackburn Rovers',4,4,'Bolton Wanderers','1888-89','FL'),
('1888-12-08','Burnley',2,1,'Stoke','1888-89','FL'),
('1888-12-08','Notts County',2,4,'Aston Villa','1888-89','FL'),
('1888-12-08','Preston North End',5,0,'Derby County','1888-89','FL'),
('1888-12-08','Wolverhampton Wanderers',4,0,'Accrington','1888-89','FL'),
('1888-12-15','Accrington',1,1,'Aston Villa','1888-89','FL'),
('1888-12-15','Blackburn Rovers',5,2,'Notts County','1888-89','FL'),
('1888-12-15','Burnley',2,2,'Preston North End','1888-89','FL'),
('1888-12-15','Stoke',0,0,'Everton','1888-89','FL'),
('1888-12-15','Wolverhampton Wanderers',2,1,'West Bromwich Albion','1888-89','FL'),
('1888-12-22','Aston Villa',4,2,'Burnley','1888-89','FL'),
('1888-12-22','Bolton Wanderers',4,1,'Accrington','1888-89','FL'),
('1888-12-22','Derby County',3,2,'Notts County','1888-89','FL'),
('1888-12-22','Preston North End',3,0,'Everton','1888-89','FL'),
('1888-12-22','West Bromwich Albion',2,1,'Blackburn Rovers','1888-89','FL'),
('1888-12-22','Wolverhampton Wanderers',4,1,'Stoke','1888-89','FL'),
('1888-12-26','Derby County',2,3,'Bolton Wanderers','1888-89','FL'),
('1888-12-26','West Bromwich Albion',0,5,'Preston North End','1888-89','FL'),
('1888-12-29','Accrington',3,1,'Everton','1888-89','FL'),
('1888-12-29','Aston Villa',4,2,'Derby County','1888-89','FL'),
('1888-12-29','Bolton Wanderers',2,1,'Wolverhampton Wanderers','1888-89','FL'),
('1888-12-29','Burnley',1,0,'Notts County','1888-89','FL'),
('1888-12-29','Preston North End',1,0,'Blackburn Rovers','1888-89','FL'),
('1888-12-29','West Bromwich Albion',2,0,'Stoke','1888-89','FL'),
('1889-01-05','Burnley',4,0,'Aston Villa','1888-89','FL'),
('1889-01-05','Preston North End',4,1,'Notts County','1888-89','FL'),
('1889-01-05','West Bromwich Albion',1,3,'Wolverhampton Wanderers','1888-89','FL'),
('1889-01-12','Aston Villa',6,2,'Bolton Wanderers','1888-89','FL'),
('1889-01-12','Blackburn Rovers',2,2,'Preston North End','1888-89','FL'),
('1889-01-12','Burnley',2,2,'Accrington','1888-89','FL'),
('1889-01-12','Derby County',3,0,'Wolverhampton Wanderers','1888-89','FL'),
('1889-01-12','Everton',2,1,'Stoke','1888-89','FL'),
('1889-01-12','Notts County',2,1,'West Bromwich Albion','1888-89','FL'),
('1889-01-19','Accrington',0,2,'Blackburn Rovers','1888-89','FL'),
('1889-01-19','Aston Villa',2,0,'West Bromwich Albion','1888-89','FL'),
('1889-01-19','Burnley',1,0,'Derby County','1888-89','FL'),
('1889-01-19','Everton',0,2,'Preston North End','1888-89','FL'),
('1889-01-19','Notts County',3,0,'Wolverhampton Wanderers','1888-89','FL'),
('1889-01-19','Stoke',2,2,'Bolton Wanderers','1888-89','FL'),
('1889-01-26','Accrington',1,2,'Notts County','1888-89','FL'),
('1889-01-26','Bolton Wanderers',3,2,'Blackburn Rovers','1888-89','FL'),
('1889-01-26','Derby County',2,1,'Stoke','1888-89','FL'),
('1889-01-26','West Bromwich Albion',3,3,'Aston Villa','1888-89','FL'),
('1889-01-26','Wolverhampton Wanderers',5,0,'Everton','1888-89','FL'),
('1889-02-04','Blackburn Rovers',4,2,'Burnley','1888-89','FL'),
('1889-02-09','Aston Villa',0,2,'Preston North End','1888-89','FL'),
('1889-02-09','Everton',1,2,'Wolverhampton Wanderers','1888-89','FL'),
('1889-02-23','West Bromwich Albion',1,0,'Everton','1888-89','FL'),
('1889-02-23','Wolverhampton Wanderers',2,1,'Notts County','1888-89','FL'),
('1889-03-02','Derby County',1,0,'Burnley','1888-89','FL'),
('1889-03-05','Notts County',0,4,'Bolton Wanderers','1888-89','FL'),
('1889-03-09','Bolton Wanderers',7,3,'Notts County','1888-89','FL'),
('1889-03-09','Derby County',5,2,'Aston Villa','1888-89','FL'),
('1889-03-16','Notts County',3,5,'Derby County','1888-89','FL'),
('1889-03-23','Accrington',2,3,'Bolton Wanderers','1888-89','FL'),
('1889-03-30','Everton',3,1,'Blackburn Rovers','1888-89','FL'),
('1889-04-06','Stoke',1,1,'Derby County','1888-89','FL'),
('1889-04-15','Blackburn Rovers',3,0,'Derby County','1888-89','FL'),
('1889-04-20','Accrington',2,0,'Stoke','1888-89','FL'),
('1889-09-07','Aston Villa',2,2,'Burnley','1889-90','FL'),
('1889-09-07','Everton',3,2,'Blackburn Rovers','1889-90','FL'),
('1889-09-07','Stoke',1,1,'Derby County','1889-90','FL'),
('1889-09-07','Wolverhampton Wanderers',2,0,'Notts County','1889-90','FL'),
('1889-09-14','Aston Villa',1,1,'Notts County','1889-90','FL'),
('1889-09-14','Blackburn Rovers',4,3,'Wolverhampton Wanderers','1889-90','FL'),
('1889-09-14','Bolton Wanderers',2,4,'Accrington','1889-90','FL'),
('1889-09-14','Derby County',3,1,'West Bromwich Albion','1889-90','FL'),
('1889-09-14','Everton',2,1,'Burnley','1889-90','FL'),
('1889-09-14','Preston North End',10,0,'Stoke','1889-90','FL'),
('1889-09-16','Wolverhampton Wanderers',2,1,'Everton','1889-90','FL'),
('1889-09-21','Aston Villa',5,3,'Preston North End','1889-90','FL'),
('1889-09-21','Blackburn Rovers',4,2,'Derby County','1889-90','FL'),
('1889-09-21','Bolton Wanderers',3,4,'Everton','1889-90','FL'),
('1889-09-21','Burnley',2,2,'Accrington','1889-90','FL'),
('1889-09-21','Notts County',1,2,'West Bromwich Albion','1889-90','FL'),
('1889-09-28','Accrington',2,2,'Blackburn Rovers','1889-90','FL'),
('1889-09-28','Burnley',0,3,'Preston North End','1889-90','FL'),
('1889-09-28','Derby County',2,0,'Notts County','1889-90','FL'),
('1889-09-28','Everton',3,0,'Bolton Wanderers','1889-90','FL'),
('1889-09-28','Stoke',2,1,'Wolverhampton Wanderers','1889-90','FL'),
('1889-09-28','West Bromwich Albion',3,0,'Aston Villa','1889-90','FL'),
('1889-09-30','Everton',1,1,'Wolverhampton Wanderers','1889-90','FL'),
('1889-10-05','Burnley',2,6,'Aston Villa','1889-90','FL'),
('1889-10-05','Derby County',2,2,'Everton','1889-90','FL'),
('1889-10-05','Notts County',3,1,'Stoke','1889-90','FL'),
('1889-10-05','Preston North End',5,0,'West Bromwich Albion','1889-90','FL'),
('1889-10-05','Wolverhampton Wanderers',2,1,'Accrington','1889-90','FL'),
('1889-10-12','Accrington',1,8,'Notts County','1889-90','FL'),
('1889-10-12','Aston Villa',7,1,'Derby County','1889-90','FL'),
('1889-10-12','Bolton Wanderers',2,6,'Preston North End','1889-90','FL'),
('1889-10-12','Burnley',1,2,'West Bromwich Albion','1889-90','FL'),
('1889-10-12','Wolverhampton Wanderers',2,2,'Stoke','1889-90','FL'),
('1889-10-19','Accrington',2,2,'Burnley','1889-90','FL'),
('1889-10-19','Blackburn Rovers',7,0,'Aston Villa','1889-90','FL'),
('1889-10-19','Derby County',2,1,'Preston North End','1889-90','FL'),
('1889-10-19','Notts County',4,3,'Everton','1889-90','FL'),
('1889-10-19','Stoke',0,1,'Bolton Wanderers','1889-90','FL'),
('1889-10-19','West Bromwich Albion',1,4,'Wolverhampton Wanderers','1889-90','FL'),
('1889-10-26','Aston Villa',1,0,'West Bromwich Albion','1889-90','FL'),
('1889-10-26','Blackburn Rovers',7,1,'Burnley','1889-90','FL'),
('1889-10-26','Bolton Wanderers',0,4,'Notts County','1889-90','FL'),
('1889-10-26','Derby County',2,0,'Stoke','1889-90','FL'),
('1889-10-26','Everton',2,2,'Accrington','1889-90','FL'),
('1889-10-26','Preston North End',0,2,'Wolverhampton Wanderers','1889-90','FL'),
('1889-11-02','Aston Villa',2,1,'Wolverhampton Wanderers','1889-90','FL'),
('1889-11-02','Blackburn Rovers',3,4,'Preston North End','1889-90','FL'),
('1889-11-02','Everton',8,0,'Stoke','1889-90','FL'),
('1889-11-02','Notts County',1,1,'Burnley','1889-90','FL'),
('1889-11-04','West Bromwich Albion',6,3,'Bolton Wanderers','1889-90','FL'),
('1889-11-09','Bolton Wanderers',3,2,'Blackburn Rovers','1889-90','FL'),
('1889-11-09','Burnley',1,2,'Wolverhampton Wanderers','1889-90','FL'),
('1889-11-09','Notts County',1,1,'Aston Villa','1889-90','FL'),
('1889-11-09','Preston North End',3,1,'Accrington','1889-90','FL'),
('1889-11-09','Stoke',1,2,'Everton','1889-90','FL'),
('1889-11-09','West Bromwich Albion',2,3,'Derby County','1889-90','FL'),
('1889-11-11','Stoke',1,2,'Preston North End','1889-90','FL'),
('1889-11-16','Accrington',6,1,'Derby County','1889-90','FL'),
('1889-11-16','Blackburn Rovers',9,1,'Notts County','1889-90','FL'),
('1889-11-16','Bolton Wanderers',2,0,'Aston Villa','1889-90','FL'),
('1889-11-16','Everton',1,5,'Preston North End','1889-90','FL'),
('1889-11-16','Stoke',1,3,'West Bromwich Albion','1889-90','FL'),
('1889-11-23','Aston Villa',1,2,'Everton','1889-90','FL'),
('1889-11-23','Blackburn Rovers',3,2,'Accrington','1889-90','FL'),
('1889-11-23','Derby County',3,3,'Wolverhampton Wanderers','1889-90','FL'),
('1889-11-23','Preston North End',3,1,'Bolton Wanderers','1889-90','FL'),
('1889-11-23','West Bromwich Albion',6,1,'Burnley','1889-90','FL'),
('1889-11-30','Accrington',4,2,'Aston Villa','1889-90','FL'),
('1889-11-30','Blackburn Rovers',5,0,'West Bromwich Albion','1889-90','FL'),
('1889-11-30','Bolton Wanderers',7,1,'Derby County','1889-90','FL'),
('1889-11-30','Preston North End',6,0,'Burnley','1889-90','FL'),
('1889-12-07','Aston Villa',6,1,'Stoke','1889-90','FL'),
('1889-12-07','Bolton Wanderers',7,0,'West Bromwich Albion','1889-90','FL'),
('1889-12-07','Everton',5,3,'Notts County','1889-90','FL'),
('1889-12-07','Preston North End',1,1,'Blackburn Rovers','1889-90','FL'),
('1889-12-07','Wolverhampton Wanderers',9,1,'Burnley','1889-90','FL'),
('1889-12-14','Notts County',0,2,'Wolverhampton Wanderers','1889-90','FL'),
('1889-12-21','Blackburn Rovers',7,1,'Bolton Wanderers','1889-90','FL'),
('1889-12-21','Notts County',3,1,'Derby County','1889-90','FL'),
('1889-12-21','Preston North End',1,2,'Everton','1889-90','FL'),
('1889-12-21','West Bromwich Albion',4,1,'Accrington','1889-90','FL'),
('1889-12-21','Wolverhampton Wanderers',1,1,'Aston Villa','1889-90','FL'),
('1889-12-23','Stoke',0,3,'Blackburn Rovers','1889-90','FL'),
('1889-12-25','Preston North End',3,2,'Aston Villa','1889-90','FL'),
('1889-12-26','Aston Villa',1,2,'Accrington','1889-90','FL'),
('1889-12-26','Derby County',3,2,'Bolton Wanderers','1889-90','FL'),
('1889-12-26','West Bromwich Albion',2,2,'Preston North End','1889-90','FL'),
('1889-12-26','Wolverhampton Wanderers',2,4,'Blackburn Rovers','1889-90','FL'),
('1889-12-28','Accrington',2,1,'Stoke','1889-90','FL'),
('1889-12-28','Blackburn Rovers',2,4,'Everton','1889-90','FL'),
('1889-12-28','Derby County',5,0,'Aston Villa','1889-90','FL'),
('1889-12-28','Wolverhampton Wanderers',1,1,'West Bromwich Albion','1889-90','FL'),
('1890-01-01','Accrington',6,3,'Wolverhampton Wanderers','1889-90','FL'),
('1890-01-04','Accrington',3,1,'Bolton Wanderers','1889-90','FL'),
('1890-01-04','Blackburn Rovers',8,0,'Stoke','1889-90','FL'),
('1890-01-04','Derby County',4,1,'Burnley','1889-90','FL'),
('1890-01-04','Everton',7,0,'Aston Villa','1889-90','FL'),
('1890-01-04','West Bromwich Albion',4,2,'Notts County','1889-90','FL'),
('1890-01-04','Wolverhampton Wanderers',0,1,'Preston North End','1889-90','FL'),
('1890-01-11','Burnley',1,3,'Stoke','1889-90','FL'),
('1890-01-11','Notts County',3,5,'Bolton Wanderers','1889-90','FL'),
('1890-01-11','Preston North End',5,0,'Derby County','1889-90','FL'),
('1890-01-11','West Bromwich Albion',3,2,'Blackburn Rovers','1889-90','FL'),
('1890-01-25','Aston Villa',1,2,'Bolton Wanderers','1889-90','FL'),
('1890-01-25','Wolverhampton Wanderers',2,1,'Derby County','1889-90','FL'),
('1890-02-08','Accrington',0,0,'West Bromwich Albion','1889-90','FL'),
('1890-02-08','Bolton Wanderers',5,0,'Stoke','1889-90','FL'),
('1890-02-08','Burnley',0,1,'Everton','1889-90','FL'),
('1890-02-08','Derby County',4,0,'Blackburn Rovers','1889-90','FL'),
('1890-02-15','Derby County',2,3,'Accrington','1889-90','FL'),
('1890-02-18','Notts County',1,1,'Blackburn Rovers','1889-90','FL'),
('1890-02-22','Accrington',5,3,'Everton','1889-90','FL'),
('1890-02-22','Burnley',1,2,'Blackburn Rovers','1889-90','FL'),
('1890-02-24','Bolton Wanderers',4,1,'Wolverhampton Wanderers','1889-90','FL'),
('1890-03-01','Burnley',7,0,'Bolton Wanderers','1889-90','FL'),
('1890-03-01','Preston North End',4,3,'Notts County','1889-90','FL'),
('1890-03-01','Stoke',7,1,'Accrington','1889-90','FL'),
('1890-03-08','Burnley',2,0,'Derby County','1889-90','FL'),
('1890-03-08','Everton',5,1,'West Bromwich Albion','1889-90','FL'),
('1890-03-10','Stoke',3,4,'Burnley','1889-90','FL'),
('1890-03-13','Notts County',3,1,'Accrington','1889-90','FL'),
('1890-03-15','Accrington',2,2,'Preston North End','1889-90','FL'),
('1890-03-15','Burnley',3,0,'Notts County','1889-90','FL'),
('1890-03-15','Everton',3,0,'Derby County','1889-90','FL'),
('1890-03-15','West Bromwich Albion',2,1,'Stoke','1889-90','FL'),
('1890-03-15','Wolverhampton Wanderers',5,1,'Bolton Wanderers','1889-90','FL'),
('1890-03-17','Bolton Wanderers',2,2,'Burnley','1889-90','FL'),
('1890-03-17','Stoke',1,1,'Aston Villa','1889-90','FL'),
('1890-03-22','West Bromwich Albion',4,1,'Everton','1889-90','FL'),
('1890-03-24','Stoke',1,1,'Notts County','1889-90','FL'),
('1890-03-27','Notts County',0,1,'Preston North End','1889-90','FL'),
('1890-03-31','Aston Villa',3,0,'Blackburn Rovers','1889-90','FL')
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
JOIN results ON teams.team_name = results.home_team 
    OR teams.team_name = results.away_team
WHERE season = '1888-89' and division = 'FL' 
GROUP BY team_name
ORDER BY Pts DESC, GA DESC, Team ASC;
