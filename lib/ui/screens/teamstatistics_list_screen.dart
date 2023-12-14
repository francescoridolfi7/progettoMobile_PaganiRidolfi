// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/teamstatistics_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_teamstatistics.dart';
import 'package:provider/provider.dart';

class TeamStatisticsListScreen extends StatefulWidget {
  const TeamStatisticsListScreen({super.key, required this.teamId, required this.selectedSeason});

  final int teamId;
  final int selectedSeason;

  @override
  TeamStatisticsListScreenState createState() => TeamStatisticsListScreenState();
}

class TeamStatisticsListScreenState extends State<TeamStatisticsListScreen> {
  @override
  Widget build(BuildContext context) {
    final teamStatisticsViewModel =
        Provider.of<TeamStatisticsViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiche della squadra', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      body: FutureBuilder<void>(
        future: teamStatisticsViewModel.fetchTeamStatistics(widget.teamId, widget.selectedSeason),
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
                      label: Text('Statistica', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
                    ),
                    DataColumn(label: Text('')),
                    DataColumn(
                      label: Text('Valore', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
                    ),
                  ],
                  rows: [
                    _buildDataRow('Games:', teamStatistics.games),
                    _buildDataRow('Fast Break Points:', teamStatistics.fastBreakPoints),
                    _buildDataRow('Points In Paint:', teamStatistics.pointsInPaint),
                    _buildDataRow('Biggest Lead:', teamStatistics.biggestLead),
                    _buildDataRow('Second Chance Points:', teamStatistics.secondChancePoints),
                    _buildDataRow('Points Off Turnovers:', teamStatistics.pointsOffTurnovers),
                    _buildDataRow('Longest Run:', teamStatistics.longestRun),
                    _buildDataRow('Points:', teamStatistics.points),
                    _buildDataRow('Field Goals Made:', teamStatistics.fgm),
                    _buildDataRow('Field Goals Attempted:', teamStatistics.fga),
                    _buildDataRow('Field Goal Percentage:', teamStatistics.fgp),
                    _buildDataRow('Free Throws Made:', teamStatistics.ftm),
                    _buildDataRow('Free Throws Attempted:', teamStatistics.fta),
                    _buildDataRow('Free Throw Percentage:', teamStatistics.ftp),
                    _buildDataRow('Three-Pointers Made:', teamStatistics.tpm),
                    _buildDataRow('Three-Pointers Attempted:', teamStatistics.tpa),
                    _buildDataRow('Three-Point Percentage:', teamStatistics.tpp),
                    _buildDataRow('Offensive Rebounds:', teamStatistics.offReb),
                    _buildDataRow('Defensive Rebounds:', teamStatistics.defReb),
                    _buildDataRow('Total Rebounds:', teamStatistics.totReb),
                    _buildDataRow('Assists:', teamStatistics.assists),
                    _buildDataRow('Personal Fouls:', teamStatistics.pFouls),
                    _buildDataRow('Steals:', teamStatistics.steals),
                    _buildDataRow('Turnovers:', teamStatistics.turnovers),
                    _buildDataRow('Blocks:', teamStatistics.blocks),
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
