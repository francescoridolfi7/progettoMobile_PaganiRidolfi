import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database database;

  Future<void> initializeDatabase() async {
    // Ottieni il percorso del database
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'nba.db');

    // Apri o crea il database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await _createTables(db);
      },
    );
  }

  Future<void> _createTables(Database db) async {
    // Table: nba_teams
    await db.execute('''
      CREATE TABLE IF NOT EXISTS nba_teams (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        nickname TEXT NOT NULL,
        code TEXT NOT NULL,
        city TEXT NOT NULL,
        logo TEXT NOT NULL,
        allStar INTEGER NOT NULL,
        nbaFranchise INTEGER NOT NULL,
        leagues_standard_conference TEXT NOT NULL,
        leagues_vegas_conference TEXT NOT NULL,
        leagues_utah_conference TEXT NOT NULL,
        leagues_sacramento_conference TEXT NOT NULL
      );
    ''');

    // Table: nba_players
    await db.execute('''
      CREATE TABLE IF NOT EXISTS nba_players (
        id INTEGER PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        birth_date TEXT NOT NULL,
        birth_country TEXT NOT NULL,
        nba_start INTEGER NOT NULL,
        nba_pro INTEGER NOT NULL,
        height_feets TEXT NOT NULL,
        height_inches TEXT NOT NULL,
        height_meters TEXT NOT NULL,
        weight_pounds TEXT NOT NULL,
        weight_kilograms TEXT NOT NULL,
        college TEXT NOT NULL,
        affiliation TEXT NOT NULL,
        leagues_standard_conference TEXT NOT NULL,
        leagues_vegas_conference TEXT NOT NULL,
        leagues_utah_conference TEXT NOT NULL,
        leagues_sacramento_conference TEXT NOT NULL
      );
    ''');

    // Table: nba_team_statistics
    await db.execute('''
      CREATE TABLE IF NOT EXISTS nba_team_statistics (
        team_id INTEGER PRIMARY KEY,
        games INTEGER NOT NULL,
        fast_break_points INTEGER NOT NULL,
        points_in_paint INTEGER NOT NULL,
        biggest_lead INTEGER NOT NULL,
        second_chance_points INTEGER NOT NULL,
        points_off_turnovers INTEGER NOT NULL,
        longest_run INTEGER NOT NULL,
        points INTEGER NOT NULL,
        fgm INTEGER NOT NULL,
        fga INTEGER NOT NULL,
        fgp REAL NOT NULL,
        ftm INTEGER NOT NULL,
        fta INTEGER NOT NULL,
        ftp REAL NOT NULL,
        tpm INTEGER NOT NULL,
        tpa INTEGER NOT NULL,
        tpp REAL NOT NULL,
        off_reb INTEGER NOT NULL,
        def_reb INTEGER NOT NULL,
        tot_reb INTEGER NOT NULL,
        assists INTEGER NOT NULL,
        p_fouls INTEGER NOT NULL,
        steals INTEGER NOT NULL,
        turnovers INTEGER NOT NULL,
        blocks INTEGER NOT NULL,
        plus_minus INTEGER NOT NULL
      );
    ''');

    // Table: nba_standings
    await db.execute('''
      CREATE TABLE IF NOT EXISTS nba_standings (
        team_id INTEGER PRIMARY KEY,
        league TEXT NOT NULL,
        season INTEGER NOT NULL,
        conference_name TEXT NOT NULL,
        conference_rank INTEGER NOT NULL,
        conference_win INTEGER NOT NULL,
        conference_loss INTEGER NOT NULL,
        division_name TEXT NOT NULL,
        division_rank INTEGER NOT NULL,
        division_win INTEGER NOT NULL,
        division_loss INTEGER NOT NULL,
        win INTEGER NOT NULL,
        loss INTEGER NOT NULL,
        games_behind TEXT NOT NULL,
        streak INTEGER NOT NULL,
        win_streak INTEGER NOT NULL,
        tie_breaker_points TEXT,
        FOREIGN KEY (team_id) REFERENCES nba_teams (id)
      );
    ''');

    // Table: nba_games
    await db.execute('''
      CREATE TABLE IF NOT EXISTS nba_games (
        id INTEGER PRIMARY KEY,
        league TEXT NOT NULL,
        season INTEGER NOT NULL,
        game_date_start TEXT NOT NULL,
        game_date_end TEXT NOT NULL,
        game_duration TEXT NOT NULL,
        stage INTEGER NOT NULL,
        status_clock TEXT,
        status_halftime INTEGER NOT NULL,
        status_short INTEGER NOT NULL,
        status_long TEXT NOT NULL,
        periods_current INTEGER NOT NULL,
        periods_total INTEGER NOT NULL,
        periods_end_of_period INTEGER NOT NULL,
        arena_name TEXT NOT NULL,
        arena_city TEXT NOT NULL,
        arena_state TEXT NOT NULL,
        arena_country TEXT NOT NULL,
        teams_visitors_id INTEGER NOT NULL,
        teams_home_id INTEGER NOT NULL,
        scores_visitors_win INTEGER NOT NULL,
        scores_visitors_loss INTEGER NOT NULL,
        scores_visitors_series_win INTEGER NOT NULL,
        scores_visitors_series_loss INTEGER NOT NULL,
        scores_visitors_linescore TEXT NOT NULL,
        scores_visitors_points INTEGER NOT NULL,
        scores_home_win INTEGER NOT NULL,
        scores_home_loss INTEGER NOT NULL,
        scores_home_series_win INTEGER NOT NULL,
        scores_home_series_loss INTEGER NOT NULL,
        scores_home_linescore TEXT NOT NULL,
        scores_home_points INTEGER NOT NULL,
        times_tied INTEGER NOT NULL,
        lead_changes INTEGER NOT NULL,
        nugget TEXT
      );
    ''');
  }

  // CRUD operations for nba_teams table
  Future<int> insertNbaTeam(Map<String, dynamic> team) async {
    final db = database;
    return await db.insert('nba_teams', team);
  }

  Future<List<Map<String, dynamic>>> getAllNbaTeams() async {
    final db = database;
    return await db.query('nba_teams');
  }

  Future<int> updateNbaTeam(Map<String, dynamic> team) async {
    final db = database;
    return await db
        .update('nba_teams', team, where: 'id = ?', whereArgs: [team['id']]);
  }

  Future<int> deleteNbaTeam(int id) async {
    final db = database;
    return await db.delete('nba_teams', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD operations for nba_players table
  Future<int> insertNbaPlayer(Map<String, dynamic> player) async {
    final db = database;
    return await db.insert('nba_players', player);
  }

  Future<List<Map<String, dynamic>>> getAllNbaPlayers() async {
    final db = database;
    return await db.query('nba_players');
  }

  Future<int> updateNbaPlayer(Map<String, dynamic> player) async {
    final db = database;
    return await db.update('nba_players', player,
        where: 'id = ?', whereArgs: [player['id']]);
  }

  Future<int> deleteNbaPlayer(int id) async {
    final db = database;
    return await db.delete('nba_players', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD operations for nba_team_statistics table
  Future<int> insertNbaTeamStatistics(Map<String, dynamic> statistics) async {
    final db = database;
    return await db.insert('nba_team_statistics', statistics);
  }

  Future<List<Map<String, dynamic>>> getAllNbaTeamStatistics() async {
    final db = database;
    return await db.query('nba_team_statistics');
  }

  Future<int> updateNbaTeamStatistics(Map<String, dynamic> statistics) async {
    final db = database;
    return await db.update('nba_team_statistics', statistics,
        where: 'team_id = ?', whereArgs: [statistics['team_id']]);
  }

  Future<int> deleteNbaTeamStatistics(int teamId) async {
    final db = database;
    return await db.delete('nba_team_statistics',
        where: 'team_id = ?', whereArgs: [teamId]);
  }

  // CRUD operations for nba_standings table
  Future<int> insertNbaStandings(Map<String, dynamic> standings) async {
    final db = database;
    return await db.insert('nba_standings', standings);
  }

  Future<List<Map<String, dynamic>>> getAllNbaStandings() async {
    final db = database;
    return await db.query('nba_standings');
  }

  Future<int> updateNbaStandings(Map<String, dynamic> standings) async {
    final db = database;
    return await db.update('nba_standings', standings,
        where: 'team_id = ?', whereArgs: [standings['team_id']]);
  }

  Future<int> deleteNbaStandings(int teamId) async {
    final db = database;
    return await db
        .delete('nba_standings', where: 'team_id = ?', whereArgs: [teamId]);
  }

  // CRUD operations for nba_games table
  Future<int> insertNbaGame(Map<String, dynamic> game) async {
    final db = database;
    return await db.insert('nba_games', game);
  }

  Future<List<Map<String, dynamic>>> getAllNbaGames() async {
    final db = database;
    return await db.query('nba_games');
  }

  Future<int> updateNbaGame(Map<String, dynamic> game) async {
    final db = database;
    return await db
        .update('nba_games', game, where: 'id = ?', whereArgs: [game['id']]);
  }

  Future<int> deleteNbaGame(int id) async {
    final db = database;
    return await db.delete('nba_games', where: 'id = ?', whereArgs: [id]);
  }

  // Helper method to close the database
  Future<void> close() async {
    final db = database;
    db.close();
  }
}
