import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';

class StandingsViewModel extends ChangeNotifier {
  final NbaApi _nbaApi;

  StandingsViewModel(this._nbaApi);

  List<dynamic>? _standings;
  List<dynamic>? get standings => _standings;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchStandings() async {
    _isLoading = true;
    notifyListeners();

    try {
      final standingsData = await _nbaApi.getNBATeamStandings();
      _standings = standingsData['response'] as List<dynamic>?;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
