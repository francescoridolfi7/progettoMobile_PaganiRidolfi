class NbaTeam {
  final int id;
  final String fullName;
  final String abbreviation;
  final String city;
  final String conference;
  final String division;

  NbaTeam({
    required this.id,
    required this.fullName,
    required this.abbreviation,
    required this.city,
    required this.conference,
    required this.division,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'abbreviation': abbreviation,
      'city': city,
      'conference': conference,
      'divisions': division,
    };
  }

  factory NbaTeam.fromJson(Map<String, dynamic> json) {
    return NbaTeam(
      id: json['id'],
      fullName: json['fullName'],
      abbreviation: json['abbreviation'],
      city: json['city'],
      conference: json['conference'],
      division: json['division'],
    );
  }
}
