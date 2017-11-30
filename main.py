from database.mysql import MySQLDatabase
from settings import db_config
from prettytable import PrettyTable

db = MySQLDatabase(db_config.get('db_name'),
                   db_config.get('user'),
                   db_config.get('pass'),
                   db_config.get('host'))


def league_table(season, division):
    build_table = db.table(season, division)
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


def team_results(team, season):
    match_results = db.team_season(team, season)
    results_list = PrettyTable(
        field_names=['Game', 'Date', 'Opponent', 'Ven.', 'Res.', 'F', 'A']
    )
    match_number = 0

    for result in match_results:
        match_number += 1
        match_details = list(result)
        match_details.insert(0, match_number)
        results_list.add_row(match_details)

    print results_list


league_table('1888-89', 'FL')
team_results('Wolverhampton Wanderers', '1888-89')
