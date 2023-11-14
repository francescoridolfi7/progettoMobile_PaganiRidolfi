import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/nba_data_storage.dart';

class TeamListViewModel extends ChangeNotifier {
  Future<List<NbaTeam>> getTeams(BuildContext context) async {
    final nbaApi = Provider.of<NbaApi>(context, listen: false);
    final teamList = await nbaApi.getNBATeamList();
    return (teamList['data'] as List<dynamic>)
        .map((teamData) => NbaTeam.fromJson(teamData))
        .toList();
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
