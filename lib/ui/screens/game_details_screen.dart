import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class GameDetailsScreen extends StatelessWidget {
  final String visitorsLogo;
  final List<String> visitorsLineScore;
  final int visitorsPoints;
  final String homeLogo;
  final List<String> homeLineScore;
  final int homePoints;

  GameDetailsScreen({
    Key? key,
    required this.visitorsLogo,
    required this.visitorsLineScore,
    required this.visitorsPoints,
    required this.homeLogo,
    required this.homeLineScore,
    required this.homePoints,
  }) : super(key: key);

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli della partita', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('')),
              DataColumn(label: Text('Q1')),
              DataColumn(label: Text('Q2')),
              DataColumn(label: Text('Q3')),
              DataColumn(label: Text('Q4')),
              DataColumn(
                label: Text('Totale', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
            rows: [
              buildDataRow(visitorsLogo, visitorsLineScore, visitorsPoints),
              buildDataRow(homeLogo, homeLineScore, homePoints),
            ],
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(String teamLogo, List<String> lineScore, int points) {
    try {
      if (isImageUrlValid(teamLogo)) {
        return DataRow(
          cells: [
            DataCell(Image.network(teamLogo, width: 30, height: 30)),
            for (String score in lineScore)
              DataCell(Center(child: Text(score))),
            DataCell(Text('$points')),
          ],
        );
      }
    } catch (e) {
      logger.e('Errore durante il caricamento dell\'immagine: $e');
    }

    return DataRow(
      cells: [
        DataCell(Container()),
        for (String score in lineScore) DataCell(Center(child: Text(score))),
        DataCell(Text('$points')),
      ],
    );
  }

  bool isImageUrlValid(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty;
  }
}
