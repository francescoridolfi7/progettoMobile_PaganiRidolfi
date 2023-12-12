// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';

class RosterViewModel extends ChangeNotifier {
  final NbaApi nbaApi;

  RosterViewModel(this.nbaApi);

  Future<List<NbaPlayer>> getRoster(int teamId) async {
    try {
      final Map<String, dynamic> rosterData = await nbaApi.getNBARoster(teamId);
      print('Roster:$rosterData');
      final List<dynamic> playerDataList = rosterData['response'] ?? [];
      print('Roster 2:$playerDataList');
      final List<NbaPlayer> roster = playerDataList.map((playerData) => NbaPlayer.fromJson(playerData)).toList();
      return roster;
    } catch (e) {
      print('Errore durante il recupero del roster: $e');
      return [];
    }
  }
}
