import 'package:flutter/material.dart';

class GameDetailsScreen extends StatelessWidget {
  final String visitorsLogo;
  final List<String> visitorsLineScore;
  final int visitorsPoints;
  final String homeLogo;
  final List<String> homeLineScore;
  final int homePoints;

  const GameDetailsScreen({
    super.key,
    required this.visitorsLogo,
    required this.visitorsLineScore,
    required this.visitorsPoints,
    required this.homeLogo,
    required this.homeLineScore,
    required this.homePoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli della partita',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTableRow(visitorsLogo, visitorsLineScore, visitorsPoints),
            buildTableRow(homeLogo, homeLineScore, homePoints),
          ],
        ),
      ),
    );
  }

  Widget buildTableRow(String teamLogo, List<String> lineScore, int points) {
    return Row(
      children: [
        Image.network(teamLogo, width: 30, height: 30),
        const SizedBox(width: 10),
        for (String score in lineScore)
          Expanded(
            child: Center(
              child: Text(score),
            ),
          ),
        const SizedBox(width: 10),
        Text('$points'),
      ],
    );
  }
}
