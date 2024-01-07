import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_games.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';


class GamesViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();


  GamesViewModel(this.nbaApi);


  List<NbaGame> _games = [];
  List<NbaGame> get games => _games;


  Future<String> _getFilePath(String date) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/games_data_$date.json';
  }


  Future<List<NbaGame>> _readGamesFromFile(String date) async {
    try {
      final file = File(await _getFilePath(date));


      if (await file.exists()) {
        final contents = await file.readAsString();
        final decodedData = json.decode(contents) as List<dynamic>;
        return decodedData.map((json) => NbaGame.fromJson(json)).toList();
      }
    } catch (e) {
      _logger.e('Errore durante la lettura dei risultati da file', error: e);
    }
    return [];
  }


  Future<void> _writeGamesToFile(String date, List<NbaGame> games) async {
    try {
      final file = File(await _getFilePath(date));
      final encodedData = json.encode(games);
      await file.writeAsString(encodedData);
    } catch (e) {
      _logger.e('Errore durante la scrittura dei risultati su file', error: e);
    }
  }


  Future<void> fetchGames(String date) async {
    try {
      final lastUpdateTimeKey = 'lastUpdateTime_$date';
      final prefs = await SharedPreferences.getInstance();
      final lastUpdateTime = prefs.getInt(lastUpdateTimeKey) ?? 0;
      final currentTime = DateTime.now().millisecondsSinceEpoch;


      if (currentTime - lastUpdateTime > 24 * 60 * 60 * 1000) {
        final gamesData = await nbaApi.getNBAGames(date);
        final responseList = gamesData['response'] as List<dynamic>?;


        if (responseList != null) {
          final gamesList = responseList
              .map((gamesJson) => NbaGame.fromJson(gamesJson))
              .toList();


          _games = gamesList;
          notifyListeners();


          await _writeGamesToFile(date, gamesList);


          await prefs.setInt(lastUpdateTimeKey, currentTime);


          // Pianifica l'attività in background
          await Workmanager().registerOneOffTask(
            "myTask",
            "simpleTask",
            inputData: {'date': date},
            initialDelay: const Duration(seconds: 10),
          );
        }
      } else {
        final cachedGames = await _readGamesFromFile(date);


        if (cachedGames.isNotEmpty) {
          _games = cachedGames;
          notifyListeners();
        }
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero dei risultati', error: e, stackTrace: stacktrace);
    }
  }
}
