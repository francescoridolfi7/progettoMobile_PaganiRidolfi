import 'dart:convert'; 
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:provider/provider.dart';

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


  Future<List<NbaTeam>> getTeams(BuildContext context) async {
    try {
      final cachedTeams = await _readTeamsFromFile();

      if (cachedTeams.isNotEmpty) {
        return cachedTeams;
      } else {
        // ignore: use_build_context_synchronously
        final nbaApi = Provider.of<NbaApi>(context, listen: false);
        final teamList = await nbaApi.getNBATeamList();

        final teamDataList = teamList['response'] as List<dynamic>?;

        if (teamDataList == null) {
          _logger.w('Attenzione: La lista delle squadre è null!');
          return [];
        }

        final teams =
            teamDataList.map((teamData) => NbaTeam.fromJson(teamData)).toList();

        if (teams.isEmpty) {
          _logger.w('Attenzione: La lista delle squadre è vuota!');
        }

        
        await _writeTeamsToFile(teams);

        return teams;
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle squadre',
          error: e, stackTrace: stacktrace);
      return [];
    }
  }
}
