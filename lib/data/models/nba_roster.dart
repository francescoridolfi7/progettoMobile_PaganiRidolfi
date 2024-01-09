class NbaPlayer {
  final int id;
  final String firstName;
  final String lastName;
  final BirthInfo birth;
  final NbaInfo nba;
  final HeightInfo height;
  final WeightInfo weight;
  final String college;
  final String affiliation;
  final Leagues leagues;

  NbaPlayer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birth,
    required this.nba,
    required this.height,
    required this.weight,
    required this.college,
    required this.affiliation,
    required this.leagues,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstName,
      'lastname': lastName,
      'birth': birth.toJson(),
      'nba': nba.toJson(),
      'height': height.toJson(),
      'weight': weight.toJson(),
      'college': college,
      'affiliation': affiliation,
      'leagues': leagues.toJson(),
    };
  }

  factory NbaPlayer.fromJson(Map<String, dynamic> json) {
    return NbaPlayer(
      id: json['id'] ?? 0,
      firstName: json['firstname'] ?? "",
      lastName: json['lastname'] ?? "",
      birth: BirthInfo.fromJson(json['birth'] ?? {}),
      nba: NbaInfo.fromJson(json['nba'] ?? {}),
      height: HeightInfo.fromJson(json['height'] ?? {}),
      weight: WeightInfo.fromJson(json['weight'] ?? {}),
      college: json['college'] ?? "",
      affiliation: json['affiliation'] ?? "",
      leagues: Leagues.fromJson(json['leagues'] ?? {}),
    );
  }
}

class BirthInfo {
  final String date;
  final String country;

  BirthInfo({
    required this.date,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'country': country,
    };
  }

  factory BirthInfo.fromJson(Map<String, dynamic> json) {
    return BirthInfo(
      date: json['date'] ?? "",
      country: json['country'] ?? "",
    );
  }
}

class NbaInfo {
  final int start;
  final int pro;

  NbaInfo({
    required this.start,
    required this.pro,
  });

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'pro': pro,
    };
  }

  factory NbaInfo.fromJson(Map<String, dynamic> json) {
    return NbaInfo(
      start: json['start'] ?? 0,
      pro: json['pro'] ?? 0,
    );
  }
}

class HeightInfo {
  final String feets;
  final String inches;
  final String meters;

  HeightInfo({
    required this.feets,
    required this.inches,
    required this.meters,
  });

  Map<String, dynamic> toJson() {
    return {
      'feets': feets,
      'inches': inches,
      'meters': meters,
    };
  }

  factory HeightInfo.fromJson(Map<String, dynamic> json) {
    return HeightInfo(
      feets: json['feets'] ?? "",
      inches: json['inches'] ?? "",
      meters: json['meters'] ?? "",
    );
  }
}

class WeightInfo {
  final String pounds;
  final String kilograms;

  WeightInfo({
    required this.pounds,
    required this.kilograms,
  });

  Map<String, dynamic> toJson() {
    return {
      'pounds': pounds,
      'kilograms': kilograms,
    };
  }

  factory WeightInfo.fromJson(Map<String, dynamic> json) {
    return WeightInfo(
      pounds: json['pounds'] ?? "",
      kilograms: json['kilograms'] ?? "",
    );
  }
}

class Leagues {
  final StandardInfo standard;

  Leagues({
    required this.standard,
  });

  Map<String, dynamic> toJson() {
    return {
      'standard': standard.toJson(),
    };
  }

  factory Leagues.fromJson(Map<String, dynamic> json) {
    return Leagues(
      standard: StandardInfo.fromJson(json['standard'] ?? {}),
    );
  }
}

class StandardInfo {
  final int jersey;
  final bool active;
  final String pos;

  StandardInfo({
    required this.jersey,
    required this.active,
    required this.pos,
  });

  Map<String, dynamic> toJson() {
    return {
      'jersey': jersey,
      'active': active,
      'pos': pos,
    };
  }

  factory StandardInfo.fromJson(Map<String, dynamic> json) {
    return StandardInfo(
      jersey: json['jersey'] ?? 0,
      active: json['active'] ?? false,
      pos: json['pos'] ?? "",
    );
  }
}
