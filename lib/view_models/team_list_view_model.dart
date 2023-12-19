import 'dart:convert';
import 'dart:io';
import 'dart:isolate';  // Aggiunto per utilizzare gli isolati
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';

class TeamListViewModel extends ChangeNotifier {
  final Logger _logger = Logger();

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/teams_data.json';
  }

  Future<List<NbaTeam>> _readTeamsFromFile() async {
    try {
      final file = File(await _getFilePath());

      if (await file.exists()) {
        final contents = await file.readAsString();
        final decodedData = json.decode(contents) as List<dynamic>;
        return decodedData.map((json) => NbaTeam.fromJson(json)).toList();
      }
    } catch (e) {
      _logger.e('Errore durante la lettura delle squadre da file', error: e);
    }
    return [];
  }

  Future<void> _writeTeamsToFile(List<NbaTeam> teams) async {
    try {
      final file = File(await _getFilePath());
      final encodedData = json.encode(teams);
      await file.writeAsString(encodedData);
    } catch (e) {
      _logger.e('Errore durante la scrittura delle squadre su file', error: e);
    }
  }

  // Funzione per eseguire la chiamata API in background
  Future<void> _fetchTeamsInBackground(SendPort sendPort) async {
    try {
      _logger.i('Inizio richiesta API in background');

      final nbaApi = NbaApi('4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb');
      final teamList = await nbaApi.getNBATeamList();

      final teamDataList = teamList['response'] as List<dynamic>?;

      if (teamDataList == null) {
        _logger.w('Attenzione: La lista delle squadre è null!');
        sendPort.send([]);
        return;
      }

      final teams =
          teamDataList.map((teamData) => NbaTeam.fromJson(teamData)).toList();

      if (teams.isEmpty) {
        _logger.w('Attenzione: La lista delle squadre è vuota!');
      }

      _logger.i('Fine richiesta API in background');

      sendPort.send(teams);
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle squadre',
          error: e, stackTrace: stacktrace);
      sendPort.send([]);
    }
  }

  Future<List<NbaTeam>> getTeams(BuildContext context) async {
    try {
      _logger.i('Inizio recupero delle squadre');

      final cachedTeams = await _readTeamsFromFile();

      if (cachedTeams.isNotEmpty) {
        _logger.i('Squadre lette dalla cache');
        return cachedTeams;
      } else {
        final receivePort = ReceivePort();

        // Avvia un nuovo isolato per eseguire la chiamata API in background
        await Isolate.spawn(_fetchTeamsInBackground, receivePort.sendPort);

        final List<NbaTeam> teams = await receivePort.first;

        if (teams.isNotEmpty) {
          await _writeTeamsToFile(teams);
        }

        _logger.i('Fine recupero delle squadre');

        return teams;
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle squadre',
          error: e, stackTrace: stacktrace);
      return [];
    }
  }
}
