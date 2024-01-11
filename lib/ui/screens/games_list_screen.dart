import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/game_details_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/games_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:logger/logger.dart';

class GamesListScreen extends StatefulWidget {
  const GamesListScreen({super.key});

  @override
  GamesListScreenState createState() => GamesListScreenState();
}

class GamesListScreenState extends State<GamesListScreen> {
  final TextEditingController _dateController = TextEditingController();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _dateController.text = getCurrentDate();
  }

  String getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

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
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime.now(),
                      selectableDayPredicate: (DateTime date) {
                        /* Restituisce false per escludere il periodo dal 11 marzo 2020 al 15 aprile 2020
                        in quanto non sono state disputate partite causa covid */
                        return !((date.isAfter(DateTime(2020, 3, 11)) &&
                            date.isBefore(DateTime(2020, 4, 16))));
                      },
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
                  logger.e('Errore: ${snapshot.error}');
                  return Center(child: Text('Errore: ${snapshot.error}'));
                } else {
                  final games = gamesViewModel.games;

                  return ListView.separated(
                    itemCount: games.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final visitorsTeam = games[index].teams.visitors;
                      final homeTeam = games[index].teams.home;

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
                                getImageWidget(visitorsTeam.logo),
                                const SizedBox(width: 12),
                                Text(
                                  '${visitorsTeam.name} - ${games[index].scores.visitors.points}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                getImageWidget(homeTeam.logo),
                                const SizedBox(width: 12),
                                Text(
                                  '${homeTeam.name} - ${games[index].scores.home.points}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Data: ${DateFormat('yyyy-MM-dd').format(games[index].date.start)}',
                              style: const TextStyle(fontSize: 14),
                            ),
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

  bool isImageUrlValid(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty;
  }

  Widget getImageWidget(String? imageUrl) {
  try {
    if (isImageUrlValid(imageUrl)) {
      return Image.network(
        imageUrl!,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          // In caso di errore nel caricamento dell'immagine, mostra il fallback_logo.png
          return Image.asset(
            'assets/fallback_logo.png',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          );
        },
      );
    }
  } catch (e) {
    logger.e('Errore durante il caricamento dell\'immagine: $e');
  }

  // Rimuovi l'immagine in caso di errore
  return Container();
}


  String getTeamAbbreviation(String teamName) {
    final words = teamName.split(' ');
    return words.isNotEmpty
        ? words[0].substring(0, min(3, words[0].length)).toUpperCase()
        : teamName;
  }
}
