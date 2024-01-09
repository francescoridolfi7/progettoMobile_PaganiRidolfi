// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/teamstatistics_list_screen.dart';

class TeamDetailsScreen extends StatelessWidget {
  final NbaTeam team;
  final List<NbaPlayer> roster;
  
  final int selectedSeason;

  const TeamDetailsScreen({Key? key, required this.team, required this.roster, required this.selectedSeason});

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
            Text(
              'Nome completo:   ${team.name}',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto', 
              ),
            ),
            Text(
              'Soprannome:   ${team.nickname}',
              style: TextStyle(
                fontSize: 18, 
                fontFamily: 'Roboto', 
              ),
            ),
            Text(
              'Città:   ${team.city}',
              style: TextStyle(
                fontSize: 18, 
                fontFamily: 'Roboto', 
              ),
            ),
            Text(
              'Conferenza:  ${team.leagues.standard.conference}',
              style: TextStyle(
                fontSize: 18, 
                fontFamily: 'Roboto', 
              ),
            ),
            Text(
              'Divisione:   ${team.leagues.standard.division}',
              style: TextStyle(
                fontSize: 18, 
                fontFamily: 'Roboto', 
              ),
            ),
            const SizedBox(height: 16),
            Image.network(
              team.logo,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamStatisticsListScreen(teamId: team.id, selectedSeason: selectedSeason),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 29, 66, 138),
              ),
              child: Text(
                'Vedi Statistiche',
                style: TextStyle(color: Colors.white),
              ),
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
                      'Numero: ${player.leagues.standard.jersey}, Paese: ${player.birth.country}, Altezza: ${player.height.feets}\'${player.height.inches}", Peso: ${player.weight.pounds} lbs, Data di nascita: ${player.birth.date}, College: ${player.college}'
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
