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

    def create_table(self, season, division):

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
                   " AS Pts"

        sql_str += " FROM teams"

        sql_str += " JOIN results ON " \
                   "teams.team_name = results.home_team " \
                   "OR " \
                   "teams.team_name = results.away_team"

        sql_str += " WHERE season = '%s' and division = '%s'" % (season, division)

        sql_str += " GROUP BY team_name"

        sql_str += " ORDER BY Pts DESC, GA DESC, Team ASC"

        sql_str += ";"

        cursor = self.db.cursor()
        cursor.execute(sql_str)
        results = cursor.fetchall()
        cursor.close()

        return results
