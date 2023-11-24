// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/nba_data_storage.dart';

class TeamListViewModel extends ChangeNotifier {
 Future<List<NbaTeam>> getTeams(BuildContext context) async {
  try {
    final nbaApi = Provider.of<NbaApi>(context, listen: false);
    final teamList = await nbaApi.getNBATeamList();
    print('Team List Response teamList: $teamList');

    final teamDataList = teamList['response'] as List<dynamic>?;
     print('Team List Response teamDataList: $teamDataList');

    if (teamDataList == null) {
      print('Attenzione: La lista delle squadre è null!');
      return [];
    }

    final teams = teamDataList.map((teamData) => NbaTeam.fromJson(teamData)).toList();
    print('Team List Response teams: $teams');

    if (teams.isEmpty) {
      print('Attenzione: La lista delle squadre è vuota!');
    }

    return teams;
  } catch (e) {
    print('Errore durante il recupero delle squadre: $e');
    // Puoi anche rilanciare l'eccezione se vuoi gestirla in modo diverso
    return [];
  }
}



  Future<void> saveTeamsLocally(List<NbaTeam> teams) async {
    final localStorageService = LocalStorageService();
    await localStorageService.saveNbaTeamData(teams);
  }
}

Future<List<NbaTeam>> loadTeamsLocally() async {
  final localStorageService = LocalStorageService();
  return await localStorageService.getNbaTeamData();
}
