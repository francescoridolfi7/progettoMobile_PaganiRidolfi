class NbaTeamStatistics {
  final int games;
  final int fastBreakPoints;
  final int pointsInPaint;
  final int biggestLead;
  final int secondChancePoints;
  final int pointsOffTurnovers;
  final int longestRun;
  final int points;
  final int fgm;
  final int fga;
  final double fgp;
  final int ftm;
  final int fta;
  final double ftp;
  final int tpm;
  final int tpa;
  final double tpp;
  final int offReb;
  final int defReb;
  final int totReb;
  final int assists;
  final int pFouls;
  final int steals;
  final int turnovers;
  final int blocks;
  final int plusMinus;

  NbaTeamStatistics({
    required this.games,
    required this.fastBreakPoints,
    required this.pointsInPaint,
    required this.biggestLead,
    required this.secondChancePoints,
    required this.pointsOffTurnovers,
    required this.longestRun,
    required this.points,
    required this.fgm,
    required this.fga,
    required this.fgp,
    required this.ftm,
    required this.fta,
    required this.ftp,
    required this.tpm,
    required this.tpa,
    required this.tpp,
    required this.offReb,
    required this.defReb,
    required this.totReb,
    required this.assists,
    required this.pFouls,
    required this.steals,
    required this.turnovers,
    required this.blocks,
    required this.plusMinus,
  });

  factory NbaTeamStatistics.fromJson(Map<String, dynamic> json) {
    return NbaTeamStatistics(
      games: _parseToInt(json['games']),
      fastBreakPoints: _parseToInt(json['fastBreakPoints']),
      pointsInPaint: _parseToInt(json['pointsInPaint']),
      biggestLead: _parseToInt(json['biggestLead']),
      secondChancePoints: _parseToInt(json['secondChancePoints']),
      pointsOffTurnovers: _parseToInt(json['pointsOffTurnovers']),
      longestRun: _parseToInt(json['longestRun']),
      points: _parseToInt(json['points']),
      fgm: _parseToInt(json['fgm']),
      fga: _parseToInt(json['fga']),
      fgp: _parseToDouble(json['fgp']),
      ftm: _parseToInt(json['ftm']),
      fta: _parseToInt(json['fta']),
      ftp: _parseToDouble(json['ftp']),
      tpm: _parseToInt(json['tpm']),
      tpa: _parseToInt(json['tpa']),
      tpp: _parseToDouble(json['tpp']),
      offReb: _parseToInt(json['offReb']),
      defReb: _parseToInt(json['defReb']),
      totReb: _parseToInt(json['totReb']),
      assists: _parseToInt(json['assists']),
      pFouls: _parseToInt(json['pFouls']),
      steals: _parseToInt(json['steals']),
      turnovers: _parseToInt(json['turnovers']),
      blocks: _parseToInt(json['blocks']),
      plusMinus: _parseToInt(json['plusMinus']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'games': games,
      'fastBreakPoints': fastBreakPoints,
      'pointsInPaint': pointsInPaint,
      'biggestLead': biggestLead,
      'secondChancePoints': secondChancePoints,
      'pointsOffTurnovers': pointsOffTurnovers,
      'longestRun': longestRun,
      'points': points,
      'fgm': fgm,
      'fga': fga,
      'fgp': fgp,
      'ftm': ftm,
      'fta': fta,
      'ftp': ftp,
      'tpm': tpm,
      'tpa': tpa,
      'tpp': tpp,
      'offReb': offReb,
      'defReb': defReb,
      'totReb': totReb,
      'assists': assists,
      'pFouls': pFouls,
      'steals': steals,
      'turnovers': turnovers,
      'blocks': blocks,
      'plusMinus': plusMinus,
    };
  }

  static int _parseToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      return 0;
    }
  }

  static double _parseToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }
}
