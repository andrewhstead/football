import MySQLdb as _mysql


class MySQLDatabase(object):

    def __init__(self, database_name, username, password, host):
        try:
            self.db = _mysql.connect(db=database_name, host=host,
                                     user=username, passwd=password)
            self.database_name = database_name
            print "Connected to MySQL!"
        except _mysql.Error, e:
            print e

    def __del__(self):
        if hasattr(self, 'db'):
            self.db.close()
            print "MySQL Connection Closed"

    def league_table(self, division, season, **kwargs):

        sql_str = "SELECT team_name AS Team, "

        sql_str += "SUM(if(teams.team_name = results.home_team " \
                   "OR teams.team_name = results.away_team" \
                   ",1,0))" \
                   " AS P, "

        sql_str += "SUM(if(teams.team_name = results.away_team " \
                   "AND results.away_score > results.home_score " \
                   "OR teams.team_name = results.home_team " \
                   "AND results.home_score > results.away_score" \
                   ",1,0))" \
                   " AS W, "

        sql_str += "SUM(IF(results.away_score = results.home_score" \
                   ",1,0))" \
                   " AS D, "

        sql_str += "SUM(if(teams.team_name = results.away_team " \
                   "AND results.away_score < results.home_score " \
                   "OR teams.team_name = results.home_team " \
                   "AND results.home_score < results.away_score" \
                   ",1,0))" \
                   " AS L, "

        sql_str += "SUM(IF(teams.team_name = results.home_team," \
                   "results.home_score,0)) " \
                   "+ SUM(IF(teams.team_name = results.away_team," \
                   "results.away_score,0))" \
                   " AS F, "

        sql_str += "SUM(IF(teams.team_name = results.home_team," \
                   "results.away_score,0)) " \
                   "+ SUM(IF(teams.team_name = results.away_team," \
                   "results.home_score,0))" \
                   " AS A, "

        sql_str += "ROUND((" \
                   "SUM(IF(teams.team_name = results.home_team," \
                   "results.home_score,0)) " \
                   "+ SUM(IF(teams.team_name = results.away_team," \
                   "results.away_score,0))) " \
                   "/ (" \
                   "SUM(IF(teams.team_name = results.home_team," \
                   "results.away_score,0)) " \
                   "+ SUM(IF(teams.team_name = results.away_team," \
                   "results.home_score,0)))" \
                   ",3)" \
                   " AS GA, "

        sql_str += "SUM(if(teams.team_name = results.away_team " \
                   "AND results.away_score > results.home_score " \
                   "OR teams.team_name = results.home_team " \
                   "AND results.home_score > results.away_score" \
                   ",2,0)) " \
                   "+ SUM(IF(results.away_score = results.home_score" \
                   ",1,0))" \
                   " AS Pts "

        sql_str += "FROM teams "

        sql_str += "JOIN results ON " \
                   "teams.team_name = results.home_team " \
                   "OR " \
                   "teams.team_name = results.away_team "

        sql_str += "WHERE division = '%s' AND season = '%s' " % (division, season)

        if 'date' in kwargs:
            sql_str += " AND results.game_date <= '%s' " % kwargs.get('date')

        sql_str += "GROUP BY team_name "

        sql_str += "ORDER BY Pts DESC, GA DESC, Team ASC"

        sql_str += ";"

        cursor = self.db.cursor()
        cursor.execute(sql_str)
        results = cursor.fetchall()
        cursor.close()

        return results

    def team_results(self, team, season):

        sql_str = "SELECT game_date AS 'Date', "

        sql_str += "IF(teams.team_name = results.home_team, " \
                   "results.away_team, results.home_team) " \
                   "AS Opponent, "

        sql_str += "IF(teams.team_name = results.home_team, " \
                   "'H', 'A') " \
                   "AS 'Ven.', "
        
        sql_str += "CASE " \
                   "WHEN(teams.team_name = results.home_team " \
                   "AND results.home_score > results.away_score) " \
                   "OR(teams.team_name = results.away_team " \
                   "AND results.away_score > results.home_score) " \
                   "THEN 'W'"

        sql_str += "WHEN results.home_score = results.away_score " \
                   "THEN 'D'"

        sql_str += "WHEN(teams.team_name = results.home_team " \
                   "AND results.home_score < results.away_score) " \
                   "OR(teams.team_name = results.away_team " \
                   "AND results.away_score < results.home_score) " \
                   "THEN 'L' "

        sql_str += "END as 'Res.', "

        sql_str += "IF(teams.team_name = results.home_team, " \
                   "results.home_score, results.away_score) " \
                   "AS F, "

        sql_str += "IF(teams.team_name = results.home_team, " \
                   "results.away_score, results.home_score) " \
                   "AS A "

        sql_str += "FROM results "

        sql_str += "JOIN teams ON " \
                   "results.home_team = teams.team_name " \
                   "OR " \
                   "results.away_team = teams.team_name "

        sql_str += "WHERE teams.team_name = '%s' AND season = '%s' " % (team, season)

        sql_str += "ORDER BY game_date ASC"\

        sql_str += ";"

        cursor = self.db.cursor()
        cursor.execute(sql_str)
        results = cursor.fetchall()
        cursor.close()

        return results

    def head_to_head(self, team_one, team_two):

        sql_str = "SELECT game_date AS 'Date', "
        sql_str += "division AS 'Div.', "
        sql_str += "home_team AS 'Home Team', "
        sql_str += "home_score AS 'HS', "
        sql_str += "away_score AS 'AS', "
        sql_str += "away_team AS 'Away Team' "

        sql_str += "FROM results "
        sql_str += "WHERE "
        sql_str += "(home_team='%s' AND away_team = '%s') " % (team_one, team_two)
        sql_str += "OR "
        sql_str += "(home_team='%s' AND away_team = '%s') " % (team_two, team_one)

        sql_str += "ORDER BY game_date ASC"
        sql_str += ";"

        cursor = self.db.cursor()
        cursor.execute(sql_str)
        results = cursor.fetchall()
        cursor.close()

        return results
