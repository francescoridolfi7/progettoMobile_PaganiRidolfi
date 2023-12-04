import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/team_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/team_details_screen.dart';

class TeamListScreen extends StatelessWidget {
  const TeamListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teamListViewModel =
        Provider.of<TeamListViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elenco Squadre NBA'),
      ),
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
                .where((team) => team.logo.isNotEmpty) // Filtra solo le squadre con logo (presumibilmente squadre NBA)
                .toList();

            return ListView.builder(
              itemCount: nbaTeams.length,
              itemBuilder: (context, index) {
                return ListTile(
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
