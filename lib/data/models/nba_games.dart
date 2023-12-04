class NbaGame {
  final int id;
  final String league;
  final int season;
  final NbaGameDate date;
  final int stage;
  final NbaGameStatus status;
  final NbaGamePeriods periods;
  final NbaGameArena arena;
  final NbaGameTeams teams;
  final NbaGameScores scores;
  final int timesTied;
  final int leadChanges;
  final dynamic nugget;

  NbaGame({
    required this.id,
    required this.league,
    required this.season,
    required this.date,
    required this.stage,
    required this.status,
    required this.periods,
    required this.arena,
    required this.teams,
    required this.scores,
    required this.timesTied,
    required this.leadChanges,
    required this.nugget,
  });

  factory NbaGame.fromJson(Map<String, dynamic> json) {
    return NbaGame(
      id: json['id'] ?? 0,
      league: json['league'] ?? '',
      season: json['season'] ?? 0,
      date: NbaGameDate.fromJson(json['date'] ?? {}),
      stage: json['stage'] ?? 0,
      status: NbaGameStatus.fromJson(json['status'] ?? {}),
      periods:NbaGamePeriods.fromJson(json['periods'] ?? {}),
      arena: NbaGameArena.fromJson(json['arena'] ?? {}),
      teams: NbaGameTeams.fromJson(json['teams'] ?? {}),
      scores: NbaGameScores.fromJson(json['scores'] ?? {}),
      timesTied: json['timesTied'] ?? 0,
      leadChanges: json['leadChanges'] ?? 0,
      nugget: json['nugget'],
    );
  }
}

class NbaGameDate {
  final DateTime start;
  final DateTime end;
  final String duration;

  NbaGameDate({
    required this.start,
    required this.end,
    required this.duration,
  });

  factory NbaGameDate.fromJson(Map<String, dynamic> json) {
    return NbaGameDate(
      start: DateTime.parse(json['start'] ?? ''),
      end: DateTime.parse(json['end'] ?? ''),
      duration: json['duration'] ?? '',
    );
  }
}

class NbaGameStatus {
  final dynamic clock;
  final bool halftime;
  final int short;
  final String long;

  NbaGameStatus({
    required this.clock,
    required this.halftime,
    required this.short,
    required this.long,
  });

  factory NbaGameStatus.fromJson(Map<String, dynamic> json) {
    return NbaGameStatus(
      clock: json['clock'],
      halftime: json['halftime'] ?? false,
      short: json['short'] ?? 0,
      long: json['long'] ?? '',
    );
  }
}

class NbaGamePeriods {
  final int current;
  final int total;
  final bool endOfPeriod;

  NbaGamePeriods({
    required this.current,
    required this.total,
    required this.endOfPeriod,
  });

  factory NbaGamePeriods.fromJson(Map<String, dynamic> json) {
    return NbaGamePeriods(
      current: json['current'] ?? 0,
      total: json['total'] ?? 0,
      endOfPeriod: json['endOfPeriod'] ?? false,
    );
  }
}

class NbaGameArena {
  final String name;
  final String city;
  final String state;
  final String country;

  NbaGameArena({
    required this.name,
    required this.city,
    required this.state,
    required this.country,
  });

  factory NbaGameArena.fromJson(Map<String, dynamic> json) {
    return NbaGameArena(
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
    );
  }
}

class NbaGameTeams {
  final NbaGameTeam visitors;
  final NbaGameTeam home;

  NbaGameTeams({
    required this.visitors,
    required this.home,
  });

  factory NbaGameTeams.fromJson(Map<String, dynamic> json) {
    return NbaGameTeams(
      visitors: NbaGameTeam.fromJson(json['visitors'] ?? {}),
      home: NbaGameTeam.fromJson(json['home'] ?? {}),
    );
  }
}

class NbaGameTeam {
  final int id;
  final String name;
  final String nickname;
  final String code;
  final String logo;

  NbaGameTeam({
    required this.id,
    required this.name,
    required this.nickname,
    required this.code,
    required this.logo,
  });

  factory NbaGameTeam.fromJson(Map<String, dynamic> json) {
    return NbaGameTeam(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nickname: json['nickname'] ?? '',
      code: json['code'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}

class NbaGameScores {
  final NbaGameTeamScore visitors;
  final NbaGameTeamScore home;

  NbaGameScores({
    required this.visitors,
    required this.home,
  });

  factory NbaGameScores.fromJson(Map<String, dynamic> json) {
    return NbaGameScores(
      visitors: NbaGameTeamScore.fromJson(json['visitors'] ?? {}),
      home: NbaGameTeamScore.fromJson(json['home'] ?? {}),
    );
  }
}

class NbaGameofficials{

}
class NbaGameTeamScore {
  final int win;
  final int loss;
  final NbaGameTeamSeries series;
  final List<String> linescore;
  final int points;

  NbaGameTeamScore({
    required this.win,
    required this.loss,
    required this.series,
    required this.linescore,
    required this.points,
  });

  factory NbaGameTeamScore.fromJson(Map<String, dynamic> json) {
    return NbaGameTeamScore(
      win: json['win'] ?? 0,
      loss: json['loss'] ?? 0,
      series: NbaGameTeamSeries.fromJson(json['series'] ?? {}),
      linescore: (json['linescore'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      points: json['points'] ?? 0,
    );
  }
}

class NbaGameTeamSeries {
  final int win;
  final int loss;

  NbaGameTeamSeries({
    required this.win,
    required this.loss,
  });

  factory NbaGameTeamSeries.fromJson(Map<String, dynamic> json) {
    return NbaGameTeamSeries(
      win: json['win'] ?? 0,
      loss: json['loss'] ?? 0,
    );
  }
}
