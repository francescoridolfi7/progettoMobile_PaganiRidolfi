import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/game_details_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/games_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GamesListScreen extends StatefulWidget {
  const GamesListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GamesListScreenState createState() => _GamesListScreenState();
}

class _GamesListScreenState extends State<GamesListScreen> {
  final TextEditingController _dateController =
      TextEditingController(text: '2022-02-12');

  @override
  Widget build(BuildContext context) {
    final gamesViewModel = Provider.of<GamesViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Risultati delle partite NBA',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Seleziona la data',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2022, 2, 12),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2023, 12, 31),
                    );

                    if (pickedDate != null) {
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      await gamesViewModel.fetchGames(_dateController.text);
                      setState(() {});
                    }
                  },
                ),
              ),
              readOnly: true,
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: gamesViewModel.fetchGames(_dateController.text),
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
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(visitorsTeam.logo,
                                    width: 40, height: 40),
                                const SizedBox(width: 12),
                                Text(
                                    '${visitorsTeam.name} - ${games[index].scores.visitors.points}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Image.network(homeTeam.logo,
                                    width: 40, height: 40),
                                const SizedBox(width: 12),
                                Text(
                                    '${homeTeam.name} - ${games[index].scores.home.points}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                                'Data: ${DateFormat('yyyy-MM-dd').format(games[index].date.start)}',
                                style: const TextStyle(fontSize: 14)),
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
                                visitorsPoints:
                                    games[index].scores.visitors.points,
                                homeLogo: homeTeam.logo,
                                homeLineScore:
                                    games[index].scores.home.linescore,
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
          ),
        ],
      ),
    );
  }
}
