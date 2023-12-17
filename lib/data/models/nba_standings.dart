import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';

class NbaStandings {
  final String league;
  final int season;
  final NbaTeam team;
  final StandingsConference conference;
  final StandingsDivision division;
  final StandingsWinLoss win;
  final StandingsWinLoss loss;
  final String gamesBehind;
  final int streak;
  final bool winStreak;
  final dynamic tieBreakerPoints;

  NbaStandings({
    required this.league,
    required this.season,
    required this.team,
    required this.conference,
    required this.division,
    required this.win,
    required this.loss,
    required this.gamesBehind,
    required this.streak,
    required this.winStreak,
    required this.tieBreakerPoints,
  });

  factory NbaStandings.fromJson(Map<String, dynamic> json) {
    return NbaStandings(
      league: json['league'] ?? '',
      season: json['season'] ?? 0,
      team: NbaTeam.fromJson(json['team'] ?? {}),
      conference: StandingsConference.fromJson(json['conference'] ?? {}),
      division: StandingsDivision.fromJson(json['division'] ?? {}),
      win: StandingsWinLoss.fromJson(json['win'] ?? {}),
      loss: StandingsWinLoss.fromJson(json['loss'] ?? {}),
      gamesBehind: json['gamesBehind'] ?? '',
      streak: json['streak'] ?? 0,
      winStreak: json['winStreak'] ?? false,
      tieBreakerPoints: json['tieBreakerPoints'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'league': league,
      'season': season,
      'team': team.toJson(),
      'conference': conference.toJson(),
      'division': division.toJson(),
      'win': win.toJson(),
      'loss': loss.toJson(),
      'gamesBehind': gamesBehind,
      'streak': streak,
      'winStreak': winStreak,
      'tieBreakerPoints': tieBreakerPoints,
    };
  }
}

class StandingsConference {
  final String name;
  final int rank;
  final int win;
  final int loss;

  StandingsConference({
    required this.name,
    required this.rank,
    required this.win,
    required this.loss,
  });

  factory StandingsConference.fromJson(Map<String, dynamic> json) {
    return StandingsConference(
      name: json['name'] ?? '',
      rank: json['rank'] ?? 0,
      win: json['win'] ?? 0,
      loss: json['loss'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rank': rank,
      'win': win,
      'loss': loss,
    };
  }
}

class StandingsDivision {
  final String name;
  final int rank;
  final int win;
  final int loss;
  final String gamesBehind;

  StandingsDivision({
    required this.name,
    required this.rank,
    required this.win,
    required this.loss,
    required this.gamesBehind,
  });

  factory StandingsDivision.fromJson(Map<String, dynamic> json) {
    return StandingsDivision(
      name: json['name'] ?? '',
      rank: json['rank'] ?? 0,
      win: json['win'] ?? 0,
      loss: json['loss'] ?? 0,
      gamesBehind: json['gamesBehind'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rank': rank,
      'win': win,
      'loss': loss,
      'gamesBehind': gamesBehind,
    };
  }
}

class StandingsWinLoss {
  final int home;
  final int away;
  final int total;
  final String percentage;
  final int lastTen;

  StandingsWinLoss({
    required this.home,
    required this.away,
    required this.total,
    required this.percentage,
    required this.lastTen,
  });

  factory StandingsWinLoss.fromJson(Map<String, dynamic> json) {
    return StandingsWinLoss(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
      total: json['total'] ?? 0,
      percentage: json['percentage'] ?? '',
      lastTen: json['lastTen'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home,
      'away': away,
      'total': total,
      'percentage': percentage,
      'lastTen': lastTen,
    };
  }
}
