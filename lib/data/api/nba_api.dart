// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class NbaApi {
  String apiKey = '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb';
  final String apiUrl = 'https://api-nba-v1.p.rapidapi.com';
  final _logger = Logger();

  NbaApi(this.apiKey);

  Future<Map<String, dynamic>> getNBATeamList() async {
    final cachedData = await _getLocalCache('teamList');
    print('Team List Response cachedData: $cachedData');
    if (cachedData != null) {
      return cachedData;
    }

    final response = await http.get(
      Uri.parse('$apiUrl/teams'),
      headers: {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Team List Response data: $data');
      _saveLocalCache('teamList', data);
      return data;
    } else {
      throw Exception('Errore nella richiesta API');
    }
  }

  Future<Map<String, dynamic>> getNBATeamDetails(int teamId) async {
    final cachedData = await _getLocalCache('teamDetails_$teamId');
    if (cachedData != null) {
      return cachedData;
    }

    final response = await http.get(
      Uri.parse('$apiUrl/teams/$teamId'),
      headers: {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      _saveLocalCache('teamDetails_$teamId', data);
      return data;
    } else {
      throw Exception(
          'Errore durante la chiamata API per i dettagli della squadra');
    }
  }

  Future<Map<String, dynamic>> getNBATeamStandings() async {
    final response = await http.get(
      Uri.parse('$apiUrl/standings'),
      headers: {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          'Errore durante la richiesta API per le statistiche delle squadre');
    }
  }

  Future<Map<String, dynamic>> getNBAGameResults() async {
    final response = await http.get(
      Uri.parse('$apiUrl/games'),
      headers: {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          'Errore durante la richiesta API per i risultati delle partite');
    }
  }

  static Future<Map<String, dynamic>> _fetchAndSaveData(
      Map<String, dynamic> args) async {
    final url = args['url'] as String;
    final cacheKey = args['cacheKey'] as String;
    final headers = args['headers'] as Map<String, String>;

    final cachedData = await _getLocalCache(cacheKey);
    if (cachedData != null) {
      return cachedData;
    }

    final response = await Dio().get(url, options: Options(headers: headers));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.data);
      _saveLocalCache(cacheKey, data);
      return data;
    } else {
      throw Exception('Errore nella richiesta API');
    }
  }

  static Future<void> _saveLocalCache(
      String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    final dataWithTimestamp = {
      'timestamp': currentTime,
      'data': data,
    };

    prefs.setString(key, jsonEncode(dataWithTimestamp));
  }

  static Future<Map<String, dynamic>?> _getLocalCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(key);

    if (cachedData != null) {
      final Map<String, dynamic> decodedData = jsonDecode(cachedData);

      final timestamp = decodedData['timestamp'] ?? 0;
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      const maxAge = 60 * 60 * 1000; // Dati validi per 1 ora

      if (currentTime - timestamp <= maxAge) {
        return decodedData['data'];
      } else {
        prefs.remove(key);
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> fetchDataAndSaveInBackground() async {
    final args = {
      'url': '$apiUrl/teams',
      'cacheKey': 'teamList',
      'headers': {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey,
      },
    };

    try {
      await _fetchAndSaveData(args);
    } catch (e) {
      _logger.e('Errore durante il recuper ed il salvataggio dei dati:$e');
    }
  }
}
