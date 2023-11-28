import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/standings_view_model.dart';
import 'package:provider/provider.dart';

class StandingsListScreen extends StatelessWidget {
  const StandingsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final standingsViewModel = Provider.of<StandingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiche delle Squadre'),
      ),
      body: _buildBody(context, standingsViewModel),
    );
  }

  Widget _buildBody(BuildContext context, StandingsViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (viewModel.standings == null || viewModel.standings!.isEmpty) {
      return const Center(child: Text('Nessuna statistica disponibile.'));
    } else {
      return ListView.builder(
        itemCount: viewModel.standings!.length,
        itemBuilder: (context, index) {
          final standing = viewModel.standings![index];

          // Puoi personalizzare il modo in cui mostri le statistiche delle squadre

          return ListTile(
            title: Text(standing['teamName'] ?? 'N/A'),
            subtitle: Text('Posizione: ${standing['position']}'),
          );
        },
      );
    }
  }
}
