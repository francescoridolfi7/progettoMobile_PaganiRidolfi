import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/database_helper.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_teamstatistics.dart';

class TeamStatisticsViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();
  final DatabaseHelper dbHelper;

  TeamStatisticsViewModel(this.nbaApi, this.dbHelper);

  NbaTeamStatistics? _teamStatistics;
  NbaTeamStatistics? get teamStatistics => _teamStatistics;

  Future<void> fetchTeamStatistics(int teamId, int selectedSeason) async {
    try {
      // Check if data is available in the local database
      final List<Map<String, dynamic>> localTeamStatistics =
          await dbHelper.getAllNbaTeamStatistics();

      if (localTeamStatistics.isNotEmpty) {
        final teamStatistics = NbaTeamStatistics.fromJson(localTeamStatistics[0]);
        _teamStatistics = teamStatistics;
        notifyListeners();
      } else {
        // If data is not available, fetch from API
        final teamStatisticsData =
            await nbaApi.getNBAStatistics(teamId, selectedSeason);
        final teamStatistics =
            NbaTeamStatistics.fromJson(teamStatisticsData['response'][0]);

        // Save data to local database
        await dbHelper.insertNbaTeamStatistics(teamStatistics.toJson());

        _teamStatistics = teamStatistics;
        notifyListeners();
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle statistiche della squadra',
          error: e, stackTrace: stacktrace);
    }
  }
}
