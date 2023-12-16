import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_games.dart';

class GamesViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();

  GamesViewModel(this.nbaApi);

  List<NbaGame> _games = [];
  List<NbaGame> get games => _games;

  Future<void> fetchGames(String date) async {
    try {
      final gamesData = await nbaApi.getNBAGames(date);

      final responseList = gamesData['response'] as List<dynamic>?;

      if (responseList != null) {
        final gamesList = responseList
            .map((gamesJson) => NbaGame.fromJson(gamesJson))
            .toList();

        _games = gamesList;
        notifyListeners();
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero dei risultati', error: e, stackTrace: stacktrace);
    }
  }
}
