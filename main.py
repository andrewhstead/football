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

league_table = db.create_table('1888-89', 'FL')

position = 0

for row in league_table:
    position += 1
    team_record = list()
    team_record.append(position)
    for entry in row:
        team_record.append(str(entry))
    print team_record
