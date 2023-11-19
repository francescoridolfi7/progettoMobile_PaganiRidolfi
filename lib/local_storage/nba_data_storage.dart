import 'dart:convert';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class LocalStorageService {
  final String _teamDataKey = 'nba_team_data';

  Future<void> saveNbaTeamData(List<NbaTeam> teams) async {
    await compute(_saveNbaTeamDataInBackground, teams);
  }

  Future<void> _saveNbaTeamDataInBackground(List<NbaTeam> teams) async {
    final prefs = await SharedPreferences.getInstance();
    final teamListJson = teams.map((team) => team.toJson()).toList();
    await prefs.setString(_teamDataKey, jsonEncode(teamListJson));
  }

  Future<List<NbaTeam>> getNbaTeamData() async {
    return await compute(_getNbaTeamDataInBackground, _teamDataKey);
  }

  Future<List<NbaTeam>> _getNbaTeamDataInBackground(String teamDataKey) async {
    final prefs = await SharedPreferences.getInstance();
    final teamDataJson = prefs.getString(teamDataKey);

    if (teamDataJson != null) {
      final teamList = jsonDecode(teamDataJson) as List<dynamic>;
      return teamList.map((teamData) => NbaTeam.fromJson(teamData)).toList();
    } else {
      return [];
    }
  }
}
