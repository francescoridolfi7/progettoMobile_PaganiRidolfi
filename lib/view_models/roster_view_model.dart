import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/database_helper.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';

class RosterViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();
  final DatabaseHelper dbHelper;

  RosterViewModel(this.nbaApi, this.dbHelper);

  Future<List<NbaPlayer>> getRoster(int teamId, int selectedSeason) async {
    try {
      // Check if data is available in the local database
      final List<Map<String, dynamic>> localRoster =
          await dbHelper.getAllNbaPlayers();

      if (localRoster.isNotEmpty) {
        final roster = localRoster
            .map((playerData) => NbaPlayer.fromJson(playerData))
            .toList();
        return roster;
      } else {
        // If data is not available, fetch from API
        final Map<String, dynamic> rosterData =
            await nbaApi.getNBARoster(teamId, selectedSeason);
        final List<dynamic> playerDataList = rosterData['response'] ?? [];
        final List<NbaPlayer> roster = playerDataList
            .map((playerData) => NbaPlayer.fromJson(playerData))
            .toList();

        // Save data to local database
        for (final player in roster) {
          await dbHelper.insertNbaPlayer(player.toJson());
        }

        return roster;
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero del roster', error: e, stackTrace: stacktrace);
      return [];
    }
  }
}
