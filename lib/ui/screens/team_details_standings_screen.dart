import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_standings.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/roster_view_model.dart';
import 'package:provider/provider.dart';

class TeamDetailsStandingsScreen extends StatelessWidget {
  final NbaStandings standings;
  final int selectedSeason;

  const TeamDetailsStandingsScreen({
    super.key,
    required this.standings,
    required this.selectedSeason,
  });

  @override
  Widget build(BuildContext context) {
    final rosterViewModel =
        Provider.of<RosterViewModel>(context, listen: false);

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
            const SizedBox(height: 16),
            const Text('Roster:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        
            FutureBuilder<List<NbaPlayer>>(
              future: rosterViewModel.getRoster(
                standings.team.id,
                selectedSeason,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Errore: ${snapshot.error}'));
                } else {
                  final List<NbaPlayer> roster = snapshot.data ?? [];

                  return Expanded(
                    child: ListView.builder(
                      itemCount: roster.length,
                      itemBuilder: (context, index) {
                        final player = roster[index];
                        return ListTile(
                          title: Text(
                              '${player.leagues.standard.pos} - ${player.firstName} ${player.lastName}'),
                          subtitle: Text(
                              'Jersey: ${player.leagues.standard.jersey}, Country: ${player.birth.country}, Height: ${player.height.feets}\'${player.height.inches}", Weight: ${player.weight.pounds} lbs, Date: ${player.birth.date}, College: ${player.college}'
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
