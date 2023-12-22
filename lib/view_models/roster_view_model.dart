import 'dart:convert'; 
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RosterViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();

  RosterViewModel(this.nbaApi);

  Future<String> _getFilePath(int teamId, int selectedSeason) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/roster_data_${teamId}_$selectedSeason.json';
  }

  Future<List<NbaPlayer>> _readRosterFromFile(int teamId, int selectedSeason) async {
    try {
      final file = File(await _getFilePath(teamId, selectedSeason));

      if (await file.exists()) {
        final contents = await file.readAsString();
        final decodedData = json.decode(contents) as List<dynamic>;
        return decodedData.map((json) => NbaPlayer.fromJson(json)).toList();
      }
    } catch (e) {
      _logger.e('Errore durante la lettura del roster da file', error: e);
    }
    return [];
  }

  Future<void> _writeRosterToFile(int teamId, int selectedSeason, List<NbaPlayer> roster) async {
    try {
      final file = File(await _getFilePath(teamId, selectedSeason));
      final encodedData = json.encode(roster);
      await file.writeAsString(encodedData);
    } catch (e) {
      _logger.e('Errore durante la scrittura del roster su file', error: e);
    }
  }


  Future<List<NbaPlayer>> getRoster(int teamId, int selectedSeason) async {
    try {
      const lastUpdateTimeKey = 'lastUpdateTimeRoster';  // Use a unique key for roster

      final prefs = await SharedPreferences.getInstance();
      final lastUpdateTime = prefs.getInt(lastUpdateTimeKey) ?? 0;
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      if (currentTime - lastUpdateTime > 24 * 60 * 60 * 1000) {
        // E' passato più di 24 ore dall'ultima chiamata API
        final cachedRoster = await _readRosterFromFile(teamId, selectedSeason);

        if (cachedRoster.isNotEmpty) {
          return cachedRoster;
        }

        final Map<String, dynamic> rosterData =
            await nbaApi.getNBARoster(teamId, selectedSeason);
        final List<dynamic> playerDataList = rosterData['response'] ?? [];
        final List<NbaPlayer> roster = playerDataList
            .map((playerData) => NbaPlayer.fromJson(playerData))
            .toList();

        await _writeRosterToFile(teamId, selectedSeason, roster);

        // Aggiorna il timestamp dell'ultima chiamata API
        await prefs.setInt(lastUpdateTimeKey, currentTime);

        return roster;
      } else {
        final cachedRoster = await _readRosterFromFile(teamId, selectedSeason);

        if (cachedRoster.isNotEmpty) {
          return cachedRoster;
        }
      }

      return [];
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero del roster', error: e, stackTrace: stacktrace);
      return [];
    }
  }
}
