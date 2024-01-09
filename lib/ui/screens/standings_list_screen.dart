import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/team_details_standings_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/standings_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_standings.dart';
import 'package:provider/provider.dart';

class StandingsListScreen extends StatefulWidget {
  const StandingsListScreen({super.key});

  @override
  StandingsListScreenState createState() => StandingsListScreenState();
}

class StandingsListScreenState extends State<StandingsListScreen> {
  int selectedSeason = 2023; // Inizializza con la stagione predefinita

  @override
  Widget build(BuildContext context) {
    final standingsViewModel =
        Provider.of<StandingsViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Classifica NBA', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<int>(
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
          ),
          Expanded(
            child: FutureBuilder<void>(
              key: ValueKey<int>(selectedSeason),
              future: standingsViewModel.fetchStandings(selectedSeason),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Errore: ${snapshot.error}'));
                } else {
                  final standings = standingsViewModel.standings;
                  final Map<String, List<NbaStandings>> standingsByConference =
                      groupStandingsByConference(standings);

                  return ListView.builder(
                    itemCount: standingsByConference.length,
                    itemBuilder: (context, conferenceIndex) {
                      final conferenceName =
                          standingsByConference.keys.elementAt(conferenceIndex);
                      final conferenceStandings =
                          standingsByConference[conferenceName]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Conference: $conferenceName',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Squadra')),
                                DataColumn(label: Text('Divisione')),
                                DataColumn(label: Text('Vittorie')),
                                DataColumn(label: Text('Sconfitte')),
                                DataColumn(label: Text('Percentuale vittorie')),
                                DataColumn(label: Text('Distanza vittorie dalla prima')),
                                DataColumn(label: Text('Streak')),
                                DataColumn(label: Text('Ultime dieci')),
                              ],
                              rows: conferenceStandings.map((team) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TeamDetailsStandingsScreen(
                                                standings: team,
                                                selectedSeason: selectedSeason,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Image.network(
                                              team.team.logo,
                                              width: 30,
                                              height: 30,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(team.team.name),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(team.division.name)),
                                    DataCell(Text('${team.win.total}')),
                                    DataCell(Text('${team.loss.total}')),
                                    DataCell(Text(team.win.percentage)),
                                    DataCell(Text(team.gamesBehind)),
                                    DataCell(Text(
                                        '${team.winStreak ? 'W' : 'L'}${team.streak}')),
                                    DataCell(Text(
                                        '${team.win.lastTen}-${team.loss.lastTen}')),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<NbaStandings>> groupStandingsByConference(
      List<NbaStandings> standings) {
    final Map<String, List<NbaStandings>> result = {};

    for (final team in standings) {
      final conferenceName = team.conference.name;
      if (!result.containsKey(conferenceName)) {
        result[conferenceName] = [];
      }
      result[conferenceName]!.add(team);
    }

    result.forEach((key, value) {
      // Ordina per numero di vittorie e, in caso di parità, per numero di sconfitte
      value.sort((a, b) {
        if (b.win.total != a.win.total) {
          return b.win.total.compareTo(a.win.total);
        } else {
          return a.loss.total.compareTo(b.loss.total);
        }
      });
    });

    return result;
  }
}
