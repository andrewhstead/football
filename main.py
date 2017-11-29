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

results = db.select('teams',
                    league_table=True,
                    columns=['team_name'],
                    join='results ON teams.team_name = results.home_team OR teams.team_name = results.away_team',
                    group_by="team_name",
                    order_desc='Pts'
                    )

position = 0

for row in results:
    position += 1
    print position, row
