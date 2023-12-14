<<<<<<< HEAD
=======

// ignore_for_file: unnecessary_brace_in_string_interps

>>>>>>> c3683378d578e97e34cb0402ce59122b3256008e
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class NbaApi {
  String apiKey = '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb';
  final String apiUrl = 'https://api-nba-v1.p.rapidapi.com';

  NbaApi(this.apiKey);

  Future<Map<String, dynamic>> getNBATeamList() async {
    final response = await http.get(
      Uri.parse('$apiUrl/teams'),
      headers: {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Errore nella richiesta API');
    }
  }

  Future<Map<String, dynamic>> getNBAStandings(int season) async {
    final Map<String, String> headers = {
      'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
      'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'league': 'standard',
      'season': season.toString(),
    };

    final Uri uri =
        Uri.parse('$apiUrl/standings').replace(queryParameters: params);

    final http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          'Errore nella richiesta HTTP. Codice di stato: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getNBAGames(String date) async {
    final Map<String, String> headers = {
      'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
      'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'date': date,
    };

    final Uri uri = Uri.parse('$apiUrl/games').replace(queryParameters: params);

    final http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          'Errore nella richiesta HTTP. Codice di stato: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getNBARoster(
      int teamId, int selectedSeason) async {
    final Map<String, String> headers = {
      'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
      'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'team': teamId.toString(),
      'season': selectedSeason.toString(),
    };

    final Uri uri =
        Uri.parse('$apiUrl/players').replace(queryParameters: params);

    final http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
        'Errore nella richiesta HTTP. Codice di stato: ${response.statusCode}',
      );
    }
  }

  Future<Map<String, dynamic>> getNBAStatistics(int teamId, int selectedSeason) async {
  final Map<String, String> headers = {
    'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
    'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
  };

  final Map<String, String> params = {
    'id': teamId.toString(),
    'season': selectedSeason.toString(),
  };

  final Uri uri = Uri.parse('$apiUrl/teams/statistics').replace(queryParameters: params);

<<<<<<< HEAD
    final http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
        'Errore nella richiesta HTTP. Codice di stato: ${response.statusCode}',
      );
    }
  }
=======
  final http.Response response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    _saveLocalCache('statistics_${selectedSeason}', data);
    return data;
  } else {
    throw Exception(
      'Errore nella richiesta HTTP. Codice di stato: ${response.statusCode}',
    );
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
>>>>>>> c3683378d578e97e34cb0402ce59122b3256008e
}
