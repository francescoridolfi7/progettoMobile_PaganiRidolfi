// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_games.dart';

class GamesViewModel extends ChangeNotifier {
  final NbaApi nbaApi;

  GamesViewModel(this.nbaApi);

  List<NbaGame> _games = [];
  List<NbaGame> get games => _games;

  Future<void> fetchGames(DateTime date) async {
    try {
      final gamesData = await nbaApi.getNBAGames();

      if (gamesData.containsKey('response')) {
        final response = gamesData['response'];

        if (response is List<dynamic>) {
          final gamesList = List<NbaGame>.from(
            response.map((gamesJson) => NbaGame.fromJson(gamesJson)),
          );

          _games = gamesList;
          notifyListeners();
        } else if (response is Map<String, dynamic>) {
          // Handling the case where 'response' is a JSON object
          final game = NbaGame.fromJson(response);
          _games = [game];
          notifyListeners();
        } else {
          print('La struttura di "response" non è quella prevista.');
        }
      } else {
        print('La risposta non contiene la chiave "response".');
      }
    } catch (e) {
      print('Errore durante il recupero dei risultati delle partite: $e');
}
}
}