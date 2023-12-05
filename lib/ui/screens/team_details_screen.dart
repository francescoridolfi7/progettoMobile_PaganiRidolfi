import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';

class TeamDetailsScreen extends StatelessWidget {
  final NbaTeam team;

  const TeamDetailsScreen({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli Squadra',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome completo: ${team.name}'),
            Text('Abbreviazione: ${team.nickname}'),
            Text('Città: ${team.city}'),
            Text('Conferenza: ${team.leagues.standard.conference}'),
            Text('Divisione: ${team.leagues.standard.division}'),
            const SizedBox(height: 16), // Aggiunto const qui
          ],
        ),
      ),
    );
  }
}
