class NbaStandings {
  final String league;
  final int season;
  final StandingsTeam team;

  NbaStandings({
    required this.league,
    required this.season,
    required this.team,
  });

  factory NbaStandings.fromJson(Map<String, dynamic> json) {
    return NbaStandings(
      league: json['league'] ?? '',
      season: json['season'] ?? 0,
      team: StandingsTeam.fromJson(json['team'] ?? {}),
    );
  }
}

class StandingsTeam {
  final int id;
  final String name;
  final String nickname;
  final String code;
  final String logo;
  final StandingsConference conference;
  final StandingsDivision division;
  final StandingsWinLoss win;
  final StandingsWinLoss loss;
  final String gamesBehind;
  final int streak;
  final bool winStreak;
  final dynamic tieBreakerPoints;

  StandingsTeam({
    required this.id,
    required this.name,
    required this.nickname,
    required this.code,
    required this.logo,
    required this.conference,
    required this.division,
    required this.win,
    required this.loss,
    required this.gamesBehind,
    required this.streak,
    required this.winStreak,
    required this.tieBreakerPoints,
  });

  factory StandingsTeam.fromJson(Map<String, dynamic> json) {
    return StandingsTeam(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nickname: json['nickname'] ?? '',
      code: json['code'] ?? '',
      logo: json['logo'] ?? '',
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
}

class StandingsConference {
  final String name;
  final int rank;

  StandingsConference({
    required this.name,
    required this.rank,
  });

  factory StandingsConference.fromJson(Map<String, dynamic> json) {
    return StandingsConference(
      name: json['name'] ?? '',
      rank: json['rank'] ?? 0,
    );
  }
}

class StandingsDivision {
  final String name;
  final int rank;

  StandingsDivision({
    required this.name,
    required this.rank,
  });

  factory StandingsDivision.fromJson(Map<String, dynamic> json) {
    return StandingsDivision(
      name: json['name'] ?? '',
      rank: json['rank'] ?? 0,
    );
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
}
