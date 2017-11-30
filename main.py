from database.mysql import MySQLDatabase
from settings import db_config
from prettytable import PrettyTable

db = MySQLDatabase(db_config.get('db_name'),
                   db_config.get('user'),
                   db_config.get('pass'),
                   db_config.get('host'))


def league_table(season, division):
    build_table = db.create_table(season, division)
    draw_table = PrettyTable(
        field_names=['Pos', 'Team', 'P', 'W', 'D', 'L', 'F', 'A', 'GA', 'Pts']
    )
    position = 0

    for team in build_table:
        position += 1
        team_record = list(team)
        team_record.insert(0, position)
        draw_table.add_row(team_record)

    print draw_table


league_table('1888-89', 'FL')
