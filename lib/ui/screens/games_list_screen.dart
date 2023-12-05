import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/game_details_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/games_view_model.dart';
import 'package:provider/provider.dart';

class GamesListScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GamesListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final gamesViewModel = Provider.of<GamesViewModel>(context, listen: false);

    // Definisci la data desiderata (2022-02-12)
    final desiredDate = DateTime(2022, 2, 12);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Risultati delle partite NBA',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: FutureBuilder<void>(
        future: gamesViewModel.fetchGames(desiredDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else {
            final games = gamesViewModel.games;

            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final visitorsTeam = games[index].teams.visitors;
                final homeTeam = games[index].teams.home;

                return ListTile(
                  title: Text(
                    'Partita #${games[index].id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(visitorsTeam.logo,
                              width: 30, height: 30),
                          const SizedBox(width: 10),
                          Text(
                              '${visitorsTeam.name} - ${games[index].scores.visitors.points}'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Image.network(homeTeam.logo, width: 30, height: 30),
                          const SizedBox(width: 10),
                          Text(
                              '${homeTeam.name} - ${games[index].scores.home.points}'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('Data: ${games[index].date.start}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameDetailsScreen(
                          visitorsLogo: visitorsTeam.logo,
                          visitorsLineScore:
                              games[index].scores.visitors.linescore,
                          visitorsPoints: games[index].scores.visitors.points,
                          homeLogo: homeTeam.logo,
                          homeLineScore: games[index].scores.home.linescore,
                          homePoints: games[index].scores.home.points,
                        ),
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
