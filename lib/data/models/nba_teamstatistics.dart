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
      games: json['games'] as int? ?? 0,
      fastBreakPoints: json['fastBreakPoints'] as int? ?? 0,
      pointsInPaint: json['pointsInPaint'] as int? ?? 0,
      biggestLead: json['biggestLead'] as int? ?? 0,
      secondChancePoints: json['secondChancePoints'] as int? ?? 0,
      pointsOffTurnovers: json['pointsOffTurnovers'] as int? ?? 0,
      longestRun: json['longestRun'] as int? ?? 0,
      points: json['points'] as int? ?? 0,
      fgm: json['fgm'] as int? ?? 0,
      fga: json['fga'] as int? ?? 0,
      fgp: json['fgp'] as double? ?? 0.0,
      ftm: json['ftm'] as int? ?? 0,
      fta: json['fta'] as int? ?? 0,
      ftp: json['ftp'] as double? ?? 0.0,
      tpm: json['tpm'] as int? ?? 0,
      tpa: json['tpa'] as int? ?? 0,
      tpp: json['tpp'] as double? ?? 0.0,
      offReb: json['offReb'] as int? ?? 0,
      defReb: json['defReb'] as int? ?? 0,
      totReb: json['totReb'] as int? ?? 0,
      assists: json['assists'] as int? ?? 0,
      pFouls: json['pFouls'] as int? ?? 0,
      steals: json['steals'] as int? ?? 0,
      turnovers: json['turnovers'] as int? ?? 0,
      blocks: json['blocks'] as int? ?? 0,
      plusMinus: json['plusMinus'] as int? ?? 0,
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
}
