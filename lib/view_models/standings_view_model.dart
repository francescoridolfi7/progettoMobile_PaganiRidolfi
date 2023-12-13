import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_standings.dart';

class StandingsViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();

  StandingsViewModel(this.nbaApi);

  List<NbaStandings> _standings = [];
  List<NbaStandings> get standings => _standings;

  Future<void> fetchStandings(int season) async {
    try {
      final standingsData = await nbaApi.getNBAStandings(season);
      final standingsList = (standingsData['response'] as List<dynamic>)
          .map((standingsJson) => NbaStandings.fromJson(standingsJson))
          .toList();

      _standings = standingsList;
      notifyListeners();
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle statistiche', error: e, stackTrace: stacktrace);
    }
  }
}
