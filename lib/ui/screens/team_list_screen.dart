import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/team_list_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/roster_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/team_details_screen.dart';
import 'package:provider/provider.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TeamListScreenState createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  int selectedSeason = 2023; // Inizializza con la stagione predefinita

  @override
  Widget build(BuildContext context) {
    final teamListViewModel = Provider.of<TeamListViewModel>(context, listen: false);
    final rosterViewModel = Provider.of<RosterViewModel>(context, listen: false);

    return Scaffold(
      body: FutureBuilder<List<NbaTeam>>(
        future: teamListViewModel.getTeams(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else {
            final List<NbaTeam> allTeams = snapshot.data ?? [];
            final List<NbaTeam> nbaTeams = allTeams
                .where((team) => team.logo.isNotEmpty && team.nbaFranchise)
                .toList();

            return ListView.builder(
              itemCount: nbaTeams.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: index == 0 ? 12 : 0),
                    ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.network(
                          nbaTeams[index].logo,
                          width: 60,
                          height: 60,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/fallback_logo.png',
                              width: 60,
                              height: 60,
                            );
                          },
                        ),
                      ),
                      title: Text(
                        nbaTeams[index].name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        final NbaTeam selectedTeam = nbaTeams[index];

                        // Recupera il roster usando la RosterViewModel
                        final List<NbaPlayer> roster = await rosterViewModel.getRoster(selectedTeam.id, selectedSeason);

                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeamDetailsScreen(
                              team: selectedTeam,
                              roster: roster,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
