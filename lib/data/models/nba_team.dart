import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';

class NbaTeam {
  final int id;
  final String name;
  final String nickname;
  final String code;
  final String city;
  final String logo;
  final bool allStar;
  final bool nbaFranchise;
  final Leagues leagues;
  final List<NbaPlayer> roster; 

  NbaTeam({
    required this.id,
    required this.name,
    required this.nickname,
    required this.code,
    required this.city,
    required this.logo,
    required this.allStar,
    required this.nbaFranchise,
    required this.leagues,
    required this.roster, 
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'code': code,
      'city': city,
      'logo': logo,
      'allStar': allStar,
      'nbaFranchise': nbaFranchise,
      'leagues': leagues.toJson(),
      'roster': roster.map((player) => player.toJson()).toList(), 
    };
  }

  factory NbaTeam.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rosterData = json['roster'] ?? [];
    final List<NbaPlayer> roster = rosterData.map((playerData) => NbaPlayer.fromJson(playerData)).toList();

    return NbaTeam(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      nickname: json['nickname'] ?? "",
      code: json['code'] ?? "",
      city: json['city'] ?? "",
      logo: json['logo'] ?? "",
      allStar: json['allStar'] ?? false,
      nbaFranchise: json['nbaFranchise'] ?? false,
      leagues: Leagues.fromJson(json['leagues'] ?? {}),
      roster: roster,
    );
  }
}


class Leagues {
  final ConferenceDivision standard;
  final ConferenceDivision vegas;
  final ConferenceDivision utah;
  final ConferenceDivision sacramento;

  Leagues({
    required this.standard,
    required this.vegas,
    required this.utah,
    required this.sacramento,
  });

  Map<String, dynamic> toJson() {
    return {
      'standard': standard.toJson(),
      'vegas': vegas.toJson(),
      'utah': utah.toJson(),
      'sacramento': sacramento.toJson(),
    };
  }

  factory Leagues.fromJson(Map<String, dynamic> json) {
    return Leagues(
      standard: ConferenceDivision.fromJson(json['standard'] ?? {}),
      vegas: ConferenceDivision.fromJson(json['vegas'] ?? {}),
      utah: ConferenceDivision.fromJson(json['utah'] ?? {}),
      sacramento: ConferenceDivision.fromJson(json['sacramento'] ?? {}),
    );
  }
}

class ConferenceDivision {
  final String conference;
  final String division;

  ConferenceDivision({
    required this.conference,
    required this.division,
  });

  Map<String, dynamic> toJson() {
    return {
      'conference': conference,
      'division': division,
    };
  }

  factory ConferenceDivision.fromJson(Map<String, dynamic> json) {
    return ConferenceDivision(
      conference: json['conference'] ?? "",
      division: json['division'] ?? "",
    );
  }
}
