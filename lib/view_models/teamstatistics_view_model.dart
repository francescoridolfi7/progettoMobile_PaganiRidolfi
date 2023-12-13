import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_teamstatistics.dart';

class TeamStatisticsViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();

  TeamStatisticsViewModel(this.nbaApi);

  NbaTeamStatistics? _teamStatistics;
  NbaTeamStatistics? get teamStatistics => _teamStatistics;

  Future<void> fetchTeamStatistics(int teamId) async {
    try {
      final teamStatisticsData = await nbaApi.getNBAStatistics(teamId);
      final teamStatistics =
          NbaTeamStatistics.fromJson(teamStatisticsData['response'][0]);
      _teamStatistics = teamStatistics;
      notifyListeners();
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle statistiche della squadra', error: e, stackTrace: stacktrace);
    }
  }
}
