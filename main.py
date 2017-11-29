from database.mysql import MySQLDatabase
from settings import db_config

"""
Retrieve the settings from the
`db_config` dictionary to connect to
our database so we can instantiate our
MySQLDatabase object
"""
db = MySQLDatabase(db_config.get('db_name'),
                   db_config.get('user'),
                   db_config.get('pass'),
                   db_config.get('host'))

results = db.select('results',
                    columns=['game_date',
                             'home_team',
                             'home_score',
                             'away_score',
                             'away_team'],
                    where="game_date='1888-09-08'"
                    )

for row in results:
    print row
