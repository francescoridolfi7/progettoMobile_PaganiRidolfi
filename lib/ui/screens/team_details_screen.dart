import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';

class TeamDetailsScreen extends StatelessWidget {
  final NbaTeam team;

  const TeamDetailsScreen({Key? key, required this.team}) : super(key: key);

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
            Text('Nome completo: ${team.name}'),
            Text('Abbreviazione: ${team.nickname}'),
            Text('Città: ${team.city}'),
            Text('Conferenza: ${team.leagues.standard.conference}'),
            Text('Divisione: ${team.leagues.standard.division}'),
            const SizedBox(height: 16),
            // Aggiunta della visualizzazione del logo
            Image.network(
              team.logo,
              width: 100, // Puoi personalizzare le dimensioni del logo secondo le tue esigenze
              height: 100,
              fit: BoxFit.contain, // Per mantenere le proporzioni del logo
            ),
          ],
        ),
      ),
    );
  }
}
