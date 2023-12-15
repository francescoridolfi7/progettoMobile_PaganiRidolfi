import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/database_helper.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_games.dart';

class GamesViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();
  final DatabaseHelper dbHelper;

  GamesViewModel(this.nbaApi, this.dbHelper);

  List<NbaGame> _games = [];
  List<NbaGame> get games => _games;

  Future<void> fetchGames(String date) async {
    try {
      // Check if data is available in the local database
      final List<Map<String, dynamic>> localGames = await dbHelper.getAllNbaGames();

      if (localGames.isNotEmpty) {
        _games = localGames.map((game) => NbaGame.fromJson(game)).toList();
        notifyListeners();
      } else {
        // If data is not available, fetch from API
        final gamesData = await nbaApi.getNBAGames(date);

        final responseList = gamesData['response'] as List<dynamic>?;

        if (responseList != null) {
          final gamesList = responseList
              .map((gamesJson) => NbaGame.fromJson(gamesJson))
              .toList();

          _games = gamesList;

          // Save data to local database
          for (final game in gamesList) {
            await dbHelper.insertNbaGame(game.toJson());
          }

          notifyListeners();
        }
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero dei risultati', error: e, stackTrace: stacktrace);
    }
  }
}
