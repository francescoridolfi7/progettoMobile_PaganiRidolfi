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

  Future<Map<String, dynamic>> getNBAStatistics(int teamId) async {
    final Map<String, String> headers = {
      'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
      'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
    };

    final Map<String, String> params = {
      'id': teamId.toString(),
      'season': '2023',
    };

    final Uri uri =
        Uri.parse('$apiUrl/teams/statistics').replace(queryParameters: params);

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
}
