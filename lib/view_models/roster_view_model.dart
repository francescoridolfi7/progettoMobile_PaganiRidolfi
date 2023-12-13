import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';

class RosterViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();

  RosterViewModel(this.nbaApi);

  Future<List<NbaPlayer>> getRoster(int teamId, int selectedSeason) async {
    try {
      final Map<String, dynamic> rosterData =
          await nbaApi.getNBARoster(teamId, selectedSeason);
      final List<dynamic> playerDataList = rosterData['response'] ?? [];
      final List<NbaPlayer> roster = playerDataList
          .map((playerData) => NbaPlayer.fromJson(playerData))
          .toList();
      return roster;
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero del roster', error: e, stackTrace: stacktrace);
      return [];
    }
  }
}
