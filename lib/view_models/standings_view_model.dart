// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_standings.dart';

class StandingsViewModel extends ChangeNotifier {
  final NbaApi nbaApi;

  StandingsViewModel(this.nbaApi);

  List<NbaStandings> _standings = [];
  List<NbaStandings> get standings => _standings;

  Future<void> fetchStandings(String league, int season) async {
    print("Fetching standings for season: $season");
    try {
      final standingsData = await nbaApi.getNBAStandings(league, season);
      print("Classifica squadre:$standingsData");
      final standingsList = (standingsData['response'] as List<dynamic>)
          .map((standingsJson) => NbaStandings.fromJson(standingsJson))
          .toList();

      _standings = standingsList;
      notifyListeners();
    } catch (e) {
      print('Errore durante il recupero delle statistiche: $e');
    }
  }
}
