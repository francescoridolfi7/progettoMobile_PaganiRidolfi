import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';

class TeamDetailsScreen extends StatelessWidget {
  final NbaTeam team;
  final List<NbaPlayer> roster;

  const TeamDetailsScreen({super.key, required this.team, required this.roster});

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
            Image.network(
              team.logo,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            const Text('Roster:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            Expanded(
              child: ListView.builder(
                itemCount: roster.length,
                itemBuilder: (context, index) {
                  final player = roster[index];
                  return ListTile(
                    title: Text('${player.leagues.standard.pos} - ${player.firstName} ${player.lastName}'),
                    subtitle: Text(
                        'Jersey: ${player.leagues.standard.jersey}, Country: ${player.birth.country}, Height: ${player.height.feets}\'${player.height.inches}", Weight: ${player.weight.pounds} lbs, Date: ${player.birth.date}, College: ${player.college}'
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
