import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_standings.dart';

class TeamDetailsStandingsScreen extends StatelessWidget {
  final NbaStandings standings;

  const TeamDetailsStandingsScreen({super.key, required this.standings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettagli Squadra', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome completo: ${standings.team.name}'),
            Text('Abbreviazione: ${standings.team.nickname}'),
            Text('Conferenza: ${standings.conference.name}'),
            Text('Divisione: ${standings.division.name}'),
            const SizedBox(height: 16),
           
            Image.network(
              standings.team.logo,
              width: 100, 
              height: 100,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
