import 'dart:convert';
import 'package:http/http.dart' as http;

class NbaApi {
  final String apiKey;
  final String apiUrl = 'rapidapi.com';

  NbaApi(this.apiKey);

  Future<Map<String, dynamic>> getNBATeamList() async {
    final response = await http.get(
      Uri.parse('$apiUrl/teams'),
      headers: {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapid.com',
        'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Errore nella richiesta API');
    }
  }

  Future<Map<String, dynamic>> getNBATeamDetails(int teamId) async {
    final response = await http.get(
      Uri.parse(
          '$apiUrl/teams/$teamId'), 
      headers: {
        'X-RapidAPI-Host': 'api-nba-v1.p.rapid.com',
        'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
          'Errore durante la chiamata API per i dettagli della squadra');
    }
  }
}
