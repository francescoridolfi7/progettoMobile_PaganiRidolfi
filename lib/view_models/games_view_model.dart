import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';

class GamesViewModel extends ChangeNotifier {
  final NbaApi _nbaApi;

  GamesViewModel(this._nbaApi);

  List<dynamic>? _gameResults;
  List<dynamic>? get gameResults => _gameResults;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchGameResults() async {
    _isLoading = true;
    notifyListeners();

    try {
      final gameResultsData = await _nbaApi.getNBAGameResults();
      _gameResults = gameResultsData['response'] as List<dynamic>?;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
