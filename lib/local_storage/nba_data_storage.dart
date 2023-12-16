import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class NbaDataStorage {
  Future<Map<String, dynamic>> fetchAndSaveData(
      String url, Map<String, String> params, String storageKey) async {
    const String apiKey = '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb';
    final Map<String, String> headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
    };


    final Uri uri = Uri.parse(url).replace(queryParameters: params);


    final http.Response response = await http.get(uri, headers: headers);


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);


      // Salva i dati in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(storageKey, json.encode(data));


      return data;
    } else {
      throw Exception(
        'Errore nella richiesta HTTP. Codice di stato: ${response.statusCode}',
      );
    }
  }
}
