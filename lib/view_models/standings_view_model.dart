import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/database_helper.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_standings.dart';

class StandingsViewModel extends ChangeNotifier {
  final NbaApi nbaApi;
  final Logger _logger = Logger();
  final DatabaseHelper dbHelper;

  StandingsViewModel(this.nbaApi, this.dbHelper);

  List<NbaStandings> _standings = [];
  List<NbaStandings> get standings => _standings;

  Future<void> fetchStandings(int season) async {
    try {
      // Check if data is available in the local database
      final List<Map<String, dynamic>> localStandings =
          await dbHelper.getAllNbaStandings();

      if (localStandings.isNotEmpty) {
        final standings = localStandings
            .map((standingsJson) => NbaStandings.fromJson(standingsJson))
            .toList();

        _standings = standings;
        notifyListeners();
      } else {
        // If data is not available, fetch from API
        final standingsData = await nbaApi.getNBAStandings(season);
        final standingsList = (standingsData['response'] as List<dynamic>)
            .map((standingsJson) => NbaStandings.fromJson(standingsJson))
            .toList();

        // Save data to local database
        for (final standing in standingsList) {
          await dbHelper.insertNbaStandings(standing.toJson());
        }

        _standings = standingsList;
        notifyListeners();
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle statistiche', error: e, stackTrace: stacktrace);
    }
  }
}
