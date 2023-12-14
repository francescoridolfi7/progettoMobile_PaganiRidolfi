// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_standings.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/teamstatistics_list_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/roster_view_model.dart';
import 'package:provider/provider.dart';

class TeamDetailsStandingsScreen extends StatefulWidget {
  final NbaStandings standings;
  final int selectedSeason;

  const TeamDetailsStandingsScreen({
    super.key,
    required this.standings,
    required this.selectedSeason,
  });

  @override
  _TeamDetailsStandingsScreenState createState() =>
      _TeamDetailsStandingsScreenState();
}

class _TeamDetailsStandingsScreenState
    extends State<TeamDetailsStandingsScreen> {
  late int selectedSeason;

  @override
  void initState() {
    super.initState();
    selectedSeason = widget.selectedSeason;
  }

  @override
  Widget build(BuildContext context) {
    final rosterViewModel =
        Provider.of<RosterViewModel>(context, listen: false);

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
            Text(
              'Nome completo: ${widget.standings.team.name}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              'Abbreviazione: ${widget.standings.team.nickname}',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              'Conferenza: ${widget.standings.conference.name}',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              'Divisione: ${widget.standings.division.name}',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 16),
            Image.network(
              widget.standings.team.logo,
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
                    builder: (context) => TeamStatisticsListScreen(
                      teamId: widget.standings.team.id,
                      selectedSeason:
                          selectedSeason, 
                    ),
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
            Row(
              children: [
                Text(
                  'Anno:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: selectedSeason,
                  onChanged: (value) {
                    setState(() {
                      selectedSeason = value!;
                    });
                  },
                  items: [2018, 2019, 2020, 2021, 2022, 2023]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Roster:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<NbaPlayer>>(
              future: rosterViewModel.getRoster(
                widget.standings.team.id,
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
                              'Jersey: ${player.leagues.standard.jersey}, Country: ${player.birth.country}, Height: ${player.height.feets}\'${player.height.inches}", Weight: ${player.weight.pounds} lbs, Date: ${player.birth.date}, College: ${player.college}'),
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
