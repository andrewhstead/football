from database.mysql import MySQLDatabase
from settings import db_config
from prettytable import PrettyTable

db = MySQLDatabase(db_config.get('db_name'),
                   db_config.get('user'),
                   db_config.get('pass'),
                   db_config.get('host'))


def league_table(division, season, **kwargs):
    collect_data = db.league_table(division, season, **kwargs)
    output = PrettyTable(
        field_names=['Pos', 'Team', 'P', 'W', 'D', 'L', 'F', 'A', 'GA', 'Pts', '+/-']
    )
    base_number = 0
    for entry in collect_data:
        base_number += 1
        record = list(entry)
        record.insert(0, base_number)
        output.add_row(record)
    print output


def team_results(team, season):
    collect_data = db.team_results(team, season)
    output = PrettyTable(
        field_names=['Game', 'Date', 'Opponent', 'Ven.', 'Res.', 'F', 'A']
    )
    base_number = 0
    for entry in collect_data:
        base_number += 1
        record = list(entry)
        record.insert(0, base_number)
        output.add_row(record)
    print output


def head_to_head(team_one, team_two):
    collect_data = db.head_to_head(team_one, team_two)
    output = PrettyTable(
        field_names=['Date', 'Div.', 'Home Team', 'HS', 'AS', 'Away Team']
    )
    for entry in collect_data:
        record = list(entry)
        output.add_row(record)
    print output


league_table('FL', '1890-91')
