import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:provider/provider.dart';

class TeamListViewModel extends ChangeNotifier {
  Future<List<NbaTeam>> getTeams(BuildContext context) async {
    final nbaApi = Provider.of<NbaApi>(context, listen: false);
    final teamList = await nbaApi.getNBATeamList();
    return (teamList['data'] as List<dynamic>)
        .map((teamData) => NbaTeam.fromJson(teamData))
        .toList();
  }
}
