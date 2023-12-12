// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_teamstatistics.dart';

class TeamStatisticsViewModel extends ChangeNotifier {
  final NbaApi nbaApi;

  TeamStatisticsViewModel(this.nbaApi);

  NbaTeamStatistics? _teamStatistics;
  NbaTeamStatistics? get teamStatistics => _teamStatistics;

  Future<void> fetchTeamStatistics(int teamId) async {
    print("Fetching team statistics for team ID: $teamId");
    try {
      final teamStatisticsData = await nbaApi.getNBAStatistics(teamId);
      print("Team Statistics: $teamStatisticsData");
      final teamStatistics =
          NbaTeamStatistics.fromJson(teamStatisticsData['response'][0]);
      _teamStatistics = teamStatistics;
      notifyListeners();
    } catch (e) {
      print('Errore durante il recupero delle statistiche della squadra: $e');
    }
  }
}
