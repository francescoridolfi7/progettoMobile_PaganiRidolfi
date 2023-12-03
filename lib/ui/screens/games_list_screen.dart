import 'package:flutter/material.dart';
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
        title: const Text('Risultati delle Partite NBA'),
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
                return ListTile(
                  title: Text(
                    'Partita #${games[index].id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Data: ${games[index].date.start}',
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
