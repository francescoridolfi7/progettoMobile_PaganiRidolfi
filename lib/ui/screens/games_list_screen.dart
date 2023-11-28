import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/games_view_model.dart';
import 'package:provider/provider.dart';

class GamesListScreen extends StatelessWidget {
  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gamesViewModel = Provider.of<GamesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Risultati delle Partite'),
      ),
      body: _buildBody(context, gamesViewModel),
    );
  }

  Widget _buildBody(BuildContext context, GamesViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (viewModel.gameResults == null || viewModel.gameResults!.isEmpty) {
      return const Center(child: Text('Nessun risultato disponibile.'));
    } else {
      return ListView.builder(
        itemCount: viewModel.gameResults!.length,
        itemBuilder: (context, index) {
          final gameResult = viewModel.gameResults![index];
          // Puoi personalizzare il modo in cui mostri i risultati delle partite
          return ListTile(
            title: Text(gameResult['homeTeam'] ?? 'N/A'),
            subtitle: Text('${gameResult['homeScore']} - ${gameResult['visitorScore']}'),
          );
        },
      );
    }
  }
}
