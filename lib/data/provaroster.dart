// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;

void main() async {
  final Uri apiUrl = Uri.parse('https://api-nba-v1.p.rapidapi.com/players');
  final Map<String, String> queryParams = {
    'team': '1',
    'season': '2021',
  };

  final Map<String, String> headers = {
    'X-RapidAPI-Key': '4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb',
    'X-RapidAPI-Host': 'api-nba-v1.p.rapidapi.com',
  };

  try {
    final response = await http.get(apiUrl.replace(queryParameters: queryParams), headers: headers);
    
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
