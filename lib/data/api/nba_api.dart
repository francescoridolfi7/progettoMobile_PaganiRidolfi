import 'dart:async';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/nba_data_storage.dart';


class NbaApi {
   final NbaDataStorage dataStorage = NbaDataStorage();


  NbaApi(String s);


  Future<Map<String, dynamic>> getNBATeamList() async {
    return dataStorage.fetchAndSaveData(
      'https://api-nba-v1.p.rapidapi.com/teams',
      {},
      'nbaTeamList',
    );
  }


  Future<Map<String, dynamic>> getNBAStandings(int season) async {
    return dataStorage.fetchAndSaveData(
      'https://api-nba-v1.p.rapidapi.com/standings',
      {'league': 'standard', 'season': season.toString()},
      'nbaStandings_$season',
    );
  }


  Future<Map<String, dynamic>> getNBAGames(String date) async {
    return dataStorage.fetchAndSaveData(
      'https://api-nba-v1.p.rapidapi.com/games',
      {'date': date},
      'nbaGames_$date',
    );
  }


  Future<Map<String, dynamic>> getNBARoster(
      int teamId, int selectedSeason) async {
    return dataStorage.fetchAndSaveData(
      'https://api-nba-v1.p.rapidapi.com/players',
      {'team': teamId.toString(), 'season': selectedSeason.toString()},
      'nbaRoster$teamId$selectedSeason',
    );
  }


  Future<Map<String, dynamic>> getNBAStatistics(
      int teamId, int selectedSeason) async {
    return dataStorage.fetchAndSaveData(
      'https://api-nba-v1.p.rapidapi.com/teams/statistics',
      {'id': teamId.toString(), 'season': selectedSeason.toString()},
      'nbaStatistics$teamId$selectedSeason',
    );
  }
}
