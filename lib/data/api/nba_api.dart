import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NbaApi {
  final String apiKey;
  final String apiUrl = 'rapidapi.com';

  NbaApi(this.apiKey);

  Future<Map<String, dynamic>> getNBATeamList() async {
    final cachedData = await _getLocalCache('teamList');
    if (cachedData != null) {
      return cachedData;
    }
    final response = await http.get(
      Uri.parse('$apiUrl/teams'),
      headers: {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapid.com',
        'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
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
        'X-RapidAPI-Host': 'api-nba-v1.p.rapid.com',
        'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
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

  Future<void> _saveLocalCache(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    //Aggiunta di un timestamp che indica quando i dati sono stati memorizzati.
    final dataWithTimestamp = {
      'timestamp': currentTime,
      'data': data,
    };

    prefs.setString(key, jsonEncode(dataWithTimestamp));
  }

  Future<Map<String, dynamic>?> _getLocalCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(key);

    if (cachedData != null) {
      final Map<String, dynamic> decodedData = jsonDecode(cachedData);

      final timestamp = decodedData['timestamp'] ?? 0;
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      const maxAge = 60 * 60 * 1000; // Dati validi per 1 ora

      if (currentTime - timestamp <= maxAge) {
        // dati validi
        return decodedData['data'];
      } else {
        // I dati sono obsoleti e vengono rimossi dalla cache
        prefs.remove(key);
        return null;
      }
    } else {
      return null;
    }
  }
}
