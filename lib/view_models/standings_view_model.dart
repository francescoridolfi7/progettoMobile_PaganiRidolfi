import 'dart:convert'; 
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_standings.dart';

class StandingsViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();

  StandingsViewModel(this.nbaApi);

  List<NbaStandings> _standings = [];
  List<NbaStandings> get standings => _standings;

  Future<String> _getFilePath(int season) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/standings_data_$season.json';
  }

  Future<List<NbaStandings>> _readStandingsFromFile(int season) async {
    try {
      final file = File(await _getFilePath(season));

      if (await file.exists()) {
        final contents = await file.readAsString();
        final decodedData = json.decode(contents) as List<dynamic>;
        return decodedData.map((json) => NbaStandings.fromJson(json)).toList();
      }
    } catch (e) {
      _logger.e('Errore durante la lettura delle classifiche da file', error: e);
    }
    return [];
  }

  Future<void> _writeStandingsToFile(int season, List<NbaStandings> standings) async {
    try {
      final file = File(await _getFilePath(season));
      final encodedData = json.encode(standings.map((standing) => standing.toJson()).toList());
      await file.writeAsString(encodedData);
    } catch (e) {
      _logger.e('Errore durante la scrittura delle classifiche su file', error: e);
    }
  }

  Future<void> fetchStandings(int season) async {
    try {
      final cachedStandings = await _readStandingsFromFile(season);

      if (cachedStandings.isNotEmpty) {
        _standings = cachedStandings;
        notifyListeners();
      } else {
        final standingsData = await nbaApi.getNBAStandings(season);
        final standingsList = (standingsData['response'] as List<dynamic>)
            .map((standingsJson) => NbaStandings.fromJson(standingsJson))
            .toList();

       
        await _writeStandingsToFile(season, standingsList);

        _standings = standingsList;
        notifyListeners();
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle classifiche', error: e, stackTrace: stacktrace);
    }
  }
}
