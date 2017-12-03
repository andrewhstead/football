use football;

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
    + (IF(teams.team_name = adjustments.team_name,adjustments.adjustment,0))
		AS Pts,
	IF(adjustments.adjustment IS NULL, '' , adjustments.adjustment) AS '+/-'
FROM teams
JOIN results ON teams.team_name = results.home_team 
    OR teams.team_name = results.away_team
LEFT JOIN adjustments ON teams.team_name = adjustments.team_name
	AND results.season = adjustments.season
WHERE results.division = 'FL' and results.season = '1890-91'
GROUP BY teams.team_name
ORDER BY Pts DESC, GA DESC, Team ASC;

# To create a list of results for one team -
SELECT
	game_date AS 'Date',
    IF(teams.team_name = results.home_team, results.away_team,results.home_team)
    AS Opponent,
    IF(teams.team_name = results.home_team, 'H', 'A') AS 'Ven.',
    CASE
		WHEN (teams.team_name = results.home_team AND results.home_score > results.away_score)
			OR (teams.team_name = results.away_team AND results.away_score > results.home_score)
				THEN 'W'
		WHEN results.home_score = results.away_score THEN 'D' 
		WHEN (teams.team_name = results.home_team AND results.home_score < results.away_score)
			OR (teams.team_name = results.away_team AND results.away_score < results.home_score)
				THEN 'L' 
		END as 'Res.',
    IF(teams.team_name = results.home_team, results.home_score, results.away_score) AS F,
    IF(teams.team_name = results.home_team, results.away_score, results.home_score) AS A
FROM results
JOIN teams ON results.home_team = teams.team_name 
    OR results.away_team = teams.team_name
JOIN clubs ON teams.club_id = clubs.id
WHERE teams.team_name = 'Burnley' AND season = '1888-89' 
	OR clubs.club_name = 'Burnley' AND season = '1888-89'
ORDER BY game_date ASC;

# To create a list of head-to-head results between two teams -
SELECT
	game_date AS 'Date',
    division AS 'Div.',
    home_team AS 'Home Team',
    home_score AS 'Sc.',
    away_score AS 'Sc.',
    away_team AS 'Away Team'
FROM results
JOIN teams AS home_team ON results.home_team = home_team.team_name
JOIN teams AS away_team ON results.away_team = away_team.team_name
JOIN clubs AS home_club ON home_team.club_id = home_club.id
JOIN clubs AS away_club ON away_team.club_id = away_club.id
WHERE (home_team.team_name = 'Stoke' AND away_team.team_name = 'Burnley'
	OR home_team.team_name = 'Burnley' AND away_team.team_name = 'Stoke')
    OR (home_club.club_name = 'Stoke' AND away_club.club_name = 'Burnley'
		OR home_club.club_name = 'Burnley' AND away_club.club_name = 'Stoke')
ORDER BY game_date ASC;