import 'dart:convert'; 
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_teamstatistics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamStatisticsViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();

  TeamStatisticsViewModel(this.nbaApi);

  NbaTeamStatistics? _teamStatistics;
  NbaTeamStatistics? get teamStatistics => _teamStatistics;

  Future<String> _getFilePath(int teamId, int selectedSeason) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/team_statistics_${teamId}_$selectedSeason.json';
  }

  Future<NbaTeamStatistics?> _readTeamStatisticsFromFile(int teamId, int selectedSeason) async {
    try {
      final file = File(await _getFilePath(teamId, selectedSeason));

      if (await file.exists()) {
        final contents = await file.readAsString();
        final decodedData = json.decode(contents) as Map<String, dynamic>;
        return NbaTeamStatistics.fromJson(decodedData);
      }
    } catch (e) {
      _logger.e('Errore durante la lettura delle statistiche della squadra da file', error: e);
    }
    return null;
  }

  Future<void> _writeTeamStatisticsToFile(int teamId, int selectedSeason, NbaTeamStatistics teamStatistics) async {
    try {
      final file = File(await _getFilePath(teamId, selectedSeason));
      final encodedData = json.encode(teamStatistics.toJson());
      await file.writeAsString(encodedData);
    } catch (e) {
      _logger.e('Errore durante la scrittura delle statistiche della squadra su file', error: e);
    }
  }


  Future<void> fetchTeamStatistics(int teamId, int selectedSeason) async {
    try {
      const lastUpdateTimeKey = 'lastUpdateTimeTeamStatistics';  // Use a unique key for team statistics

      final prefs = await SharedPreferences.getInstance();
      final lastUpdateTime = prefs.getInt(lastUpdateTimeKey) ?? 0;
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      if (currentTime - lastUpdateTime > 24 * 60 * 60 * 1000) {
        // E' passato più di 24 ore dall'ultima chiamata API
        final cachedTeamStatistics = await _readTeamStatisticsFromFile(teamId, selectedSeason);

        if (cachedTeamStatistics != null) {
          _teamStatistics = cachedTeamStatistics;
          notifyListeners();
        }

        final teamStatisticsData = await nbaApi.getNBAStatistics(teamId, selectedSeason);
        final teamStatistics = NbaTeamStatistics.fromJson(teamStatisticsData['response'][0]);

        await _writeTeamStatisticsToFile(teamId, selectedSeason, teamStatistics);

        _teamStatistics = teamStatistics;
        notifyListeners();

        // Aggiorna il timestamp dell'ultima chiamata API
        await prefs.setInt(lastUpdateTimeKey, currentTime);
      } else {
        final cachedTeamStatistics = await _readTeamStatisticsFromFile(teamId, selectedSeason);

        if (cachedTeamStatistics != null) {
          _teamStatistics = cachedTeamStatistics;
          notifyListeners();
        }
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle statistiche della squadra', error: e, stackTrace: stacktrace);
    }
  }
}
