// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/teamstatistics_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_teamstatistics.dart';
import 'package:provider/provider.dart';

class TeamStatisticsListScreen extends StatefulWidget {
  const TeamStatisticsListScreen(
      {super.key, required this.teamId, required this.selectedSeason});

  final int teamId;
  final int selectedSeason;

  @override
  TeamStatisticsListScreenState createState() =>
      TeamStatisticsListScreenState();
}

class TeamStatisticsListScreenState extends State<TeamStatisticsListScreen> {
  @override
  Widget build(BuildContext context) {
    final teamStatisticsViewModel =
        Provider.of<TeamStatisticsViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiche della squadra',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: FutureBuilder<void>(
        future: teamStatisticsViewModel.fetchTeamStatistics(
            widget.teamId, widget.selectedSeason),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errore: ${snapshot.error}'));
          } else {
            final teamStatistics = teamStatisticsViewModel.teamStatistics ??
                NbaTeamStatistics(
                  games: 0,
                  fastBreakPoints: 0,
                  pointsInPaint: 0,
                  biggestLead: 0,
                  secondChancePoints: 0,
                  pointsOffTurnovers: 0,
                  longestRun: 0,
                  points: 0,
                  fgm: 0,
                  fga: 0,
                  fgp: 0,
                  ftm: 0,
                  fta: 0,
                  ftp: 0,
                  tpm: 0,
                  tpa: 0,
                  tpp: 0,
                  offReb: 0,
                  defReb: 0,
                  totReb: 0,
                  assists: 0,
                  pFouls: 0,
                  steals: 0,
                  turnovers: 0,
                  blocks: 0,
                  plusMinus: 0,
                );

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 32,
                  columns: [
                    DataColumn(
                      label: Text('Statistica',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto')),
                    ),
                    DataColumn(label: Text('')),
                    DataColumn(
                      label: Text('Valore',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto')),
                    ),
                  ],
                  rows: [
                    _buildDataRow('Partite giocate:', teamStatistics.games),
                    _buildDataRow('Punti in transizione veloce:',
                        teamStatistics.fastBreakPoints),
                    _buildDataRow(
                        'Punti in area dipinta:', teamStatistics.pointsInPaint),
                    _buildDataRow(
                        'Vantaggio più ampio:', teamStatistics.biggestLead),
                    _buildDataRow('Punti da seconde possibilità:',
                        teamStatistics.secondChancePoints),
                    _buildDataRow('Punti da palle perse avversarie:',
                        teamStatistics.pointsOffTurnovers),
                    _buildDataRow(
                        'Striscia più lunga:', teamStatistics.longestRun),
                    _buildDataRow('Punti totali:', teamStatistics.points),
                    _buildDataRow('Canestri segnati:', teamStatistics.fgm),
                    _buildDataRow('Tiri tentati:', teamStatistics.fga),
                    _buildDataRow(
                        'Percentuale da due punti:', teamStatistics.fgp),
                    _buildDataRow('Liberi segnati:', teamStatistics.ftm),
                    _buildDataRow('Liberi tentati:', teamStatistics.fta),
                    _buildDataRow('Percentuale ai liberi:', teamStatistics.ftp),
                    _buildDataRow('Triple segnate:', teamStatistics.tpm),
                    _buildDataRow('Triple tentate:', teamStatistics.tpa),
                    _buildDataRow(
                        'Percentuale da tre punti:', teamStatistics.tpp),
                    _buildDataRow('Rimbalzi offensivi:', teamStatistics.offReb),
                    _buildDataRow('Rimbalzi difensivi:', teamStatistics.defReb),
                    _buildDataRow('Rimbalzi totali:', teamStatistics.totReb),
                    _buildDataRow('Assist:', teamStatistics.assists),
                    _buildDataRow('Falli personali:', teamStatistics.pFouls),
                    _buildDataRow('Rubate:', teamStatistics.steals),
                    _buildDataRow('Palle perse:', teamStatistics.turnovers),
                    _buildDataRow('Stoppate:', teamStatistics.blocks),
                    _buildDataRow('Plus-Minus:', teamStatistics.plusMinus),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  DataRow _buildDataRow(String label, num value) {
    return DataRow(cells: [
      DataCell(Text(label)),
      DataCell(Container(width: 90)),
      DataCell(Text(value.toString())),
    ]);
  }
}
