import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/nba_data_storage.dart';

class TeamListViewModel extends ChangeNotifier {
  final Logger _logger = Logger();

  Future<List<NbaTeam>> getTeams(BuildContext context) async {
    try {
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

      return teams;
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle squadre', error: e, stackTrace: stacktrace);
      return [];
    }
  }

  Future<void> saveTeamsLocally(List<NbaTeam> teams) async {
    final localStorageService = LocalStorageService();
    await localStorageService.saveNbaTeamData(teams);
  }

  Future<List<NbaTeam>> loadTeamsLocally() async {
    final localStorageService = LocalStorageService();
    return await localStorageService.getNbaTeamData();
  }
}
