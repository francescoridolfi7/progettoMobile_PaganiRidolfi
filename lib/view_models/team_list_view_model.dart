import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/database_helper.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:provider/provider.dart';

class TeamListViewModel extends ChangeNotifier {
  final Logger _logger = Logger();
  final DatabaseHelper dbHelper;

  TeamListViewModel(this.dbHelper);

  Future<List<NbaTeam>> getTeams(BuildContext context) async {
    try {
      // Check if data is available in the local database
      final List<Map<String, dynamic>> localTeams =
          await dbHelper.getAllNbaTeams();

      if (localTeams.isNotEmpty) {
        final teams =
            localTeams.map((teamData) => NbaTeam.fromJson(teamData)).toList();
        return teams;
      } else {
        // If data is not available, fetch from API
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

        // Save data to local database
        for (final team in teams) {
          await dbHelper.insertNbaTeam(team.toJson());
        }

        return teams;
      }
    } catch (e, stacktrace) {
      _logger.e('Errore durante il recupero delle squadre',
          error: e, stackTrace: stacktrace);
      return [];
    }
  }
}
