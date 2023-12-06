import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/game_details_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/games_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GamesListScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GamesListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final gamesViewModel = Provider.of<GamesViewModel>(context, listen: false);

   
    final desiredDate = DateTime(2022, 2, 12);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Risultati delle partite NBA', style: TextStyle(color: Colors.white)),
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

            return ListView.separated(
              itemCount: games.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final visitorsTeam = games[index].teams.visitors;
                final homeTeam = games[index].teams.home;

                String getTeamAbbreviation(String teamName) {
                  final words = teamName.split(' ');
                  return words.length >= 2
                      ? words[0].substring(0, 3).toUpperCase()
                      : teamName;
                }

                return ListTile(
                  title: Text(
                    'Partita: ${getTeamAbbreviation(visitorsTeam.name)} vs ${getTeamAbbreviation(homeTeam.name)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(visitorsTeam.logo, width: 30, height: 30),
                          const SizedBox(width: 10),
                          Text('${visitorsTeam.name} - ${games[index].scores.visitors.points}'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Image.network(homeTeam.logo, width: 30, height: 30),
                          const SizedBox(width: 10),
                          Text('${homeTeam.name} - ${games[index].scores.home.points}'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('Data: ${DateFormat('yyyy-MM-dd').format(games[index].date.start)}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameDetailsScreen(
                          visitorsLogo: visitorsTeam.logo,
                          visitorsLineScore: games[index].scores.visitors.linescore,
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
