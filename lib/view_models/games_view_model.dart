// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_games.dart';

class GamesViewModel extends ChangeNotifier {
  final NbaApi nbaApi;

  GamesViewModel(this.nbaApi);

  List<NbaGame> _games = [];
  List<NbaGame> get games => _games;

  Future<void> fetchGames(String date) async {
    try {
      final gamesData = await nbaApi.getNBAGames(date);
      print("Risultati squadre:$gamesData");
      final gamesList = (gamesData['response'] as List<dynamic>)
          .map((gamesJson) => NbaGame.fromJson(gamesJson))
          .toList();

      _games = gamesList;
      notifyListeners();
    } catch (e) {
      print('Errore durante il recupero dei risultati: $e');
    }
  }
}
