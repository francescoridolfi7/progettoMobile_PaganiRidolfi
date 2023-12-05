// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/team_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/team_details_screen.dart';

class TeamListScreen extends StatelessWidget {
  const TeamListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final teamListViewModel =
        Provider.of<TeamListViewModel>(context, listen: false);

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
                return ListTile(
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.network(
                      nbaTeams[index].logo,
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        // Gestisci l'errore mostrando un'immagine di fallback
                        return Image.asset(
                          'assets/fallback_logo.png', // Sostituisci con il percorso dell'immagine di fallback nel tuo progetto
                          width: 40,
                          height: 40,
                        );
                      },
                    ),
                  ),
                  title: Text(nbaTeams[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TeamDetailsScreen(team: nbaTeams[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
