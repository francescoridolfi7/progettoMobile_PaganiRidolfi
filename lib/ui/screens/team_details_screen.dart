import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:provider/provider.dart';

class TeamDetailsViewModel extends ChangeNotifier {
  Future<NbaTeam> getTeamDetails(BuildContext context, int teamId) async {
    final nbaApi = Provider.of<NbaApi>(context, listen: false);
    final teamDetails = await nbaApi.getNBATeamDetails(teamId);
    return NbaTeam.fromJson(teamDetails['data']);
  }
}
