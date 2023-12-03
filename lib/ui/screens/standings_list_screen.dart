import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/standings_view_model.dart';
import 'package:provider/provider.dart';

class StandingsListScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const StandingsListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final standingsViewModel =
        Provider.of<StandingsViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classifica NBA'),
      ),
      body: FutureBuilder<void>(
        future: standingsViewModel.fetchStandings('standard', 2021),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else {
            final standings = standingsViewModel.standings;

            return ListView.builder(
              itemCount: standings.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    standings[index].team.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Conference: ${standings[index].team.conference.name}, Division: ${standings[index].team.division.name}',
                  ),
                  leading: Image.network(
                    standings[index].team.logo,
                    width: 50,
                    height: 50,
                  ),
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
    );
  }
}
