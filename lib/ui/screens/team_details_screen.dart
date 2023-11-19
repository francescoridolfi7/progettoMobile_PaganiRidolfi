import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';

class TeamDetailsScreen extends StatelessWidget {
  final NbaTeam team;

  TeamDetailsScreen({required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli Squadra'), // Aggiunto const qui
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome completo: ${team.fullName}'),
            Text('Abbreviazione: ${team.abbreviation}'),
            Text('Città: ${team.city}'),
            Text('Conferenza: ${team.conference}'),
            Text('Divisione: ${team.division}'),
            const SizedBox(height: 16), // Aggiunto const qui
            const Text('Statistiche della squadra:'), // Aggiunto const qui
            DataTable(
              columns: const [
                DataColumn(label: Text('Statistica')),
                DataColumn(label: Text('Valore')),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('Punteggio medio per partita')),
                  DataCell(Text('25.4')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Rimbalzi medi per partita')),
                  DataCell(Text('45.7')),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
