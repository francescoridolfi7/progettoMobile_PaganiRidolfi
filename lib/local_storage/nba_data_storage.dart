import 'dart:convert';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final String _teamDataKey = 'nba_team_data';

  Future<void> saveNbaTeamData(List<NbaTeam> teams) async {
    final prefs = await SharedPreferences.getInstance();
    final teamListJson = teams.map((team) => team.toJson()).toList();
    await prefs.setString(_teamDataKey, jsonEncode(teamListJson));
  }

  Future<List<NbaTeam>> getNbaTeamData() async {
    final prefs = await SharedPreferences.getInstance();
    final teamDataJson = prefs.getString(_teamDataKey);

    if (teamDataJson != null) {
      final teamList = jsonDecode(teamDataJson) as List<dynamic>;
      return teamList.map((teamData) => NbaTeam.fromJson(teamData)).toList();
    } else {
      return [];
    }
  }
}
