import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/teamstatistics_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_teamstatistics.dart';
import 'package:provider/provider.dart';

class TeamStatisticsListScreen extends StatefulWidget {
  const TeamStatisticsListScreen({super.key, required this.teamId, required this.selectedSeason});

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

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildStatisticRow('Games:', teamStatistics.games),
                _buildStatisticRow(
                    'Fast Break Points:', teamStatistics.fastBreakPoints),
                _buildStatisticRow(
                    'Points In Paint:', teamStatistics.pointsInPaint),
                _buildStatisticRow('Biggest Lead:', teamStatistics.biggestLead),
                _buildStatisticRow(
                    'Second Chance Points:', teamStatistics.secondChancePoints),
                _buildStatisticRow(
                    'Points Off Turnovers:', teamStatistics.pointsOffTurnovers),
                _buildStatisticRow('Longest Run:', teamStatistics.longestRun),
                _buildStatisticRow('Points:', teamStatistics.points),
                _buildStatisticRow('Field Goals Made:', teamStatistics.fgm),
                _buildStatisticRow(
                    'Field Goals Attempted:', teamStatistics.fga),
                _buildStatisticRow(
                    'Field Goal Percentage:', teamStatistics.fgp),
                _buildStatisticRow('Free Throws Made:', teamStatistics.ftm),
                _buildStatisticRow(
                    'Free Throws Attempted:', teamStatistics.fta),
                _buildStatisticRow(
                    'Free Throw Percentage:', teamStatistics.ftp),
                _buildStatisticRow('Three-Pointers Made:', teamStatistics.tpm),
                _buildStatisticRow(
                    'Three-Pointers Attempted:', teamStatistics.tpa),
                _buildStatisticRow(
                    'Three-Point Percentage:', teamStatistics.tpp),
                _buildStatisticRow(
                    'Offensive Rebounds:', teamStatistics.offReb),
                _buildStatisticRow(
                    'Defensive Rebounds:', teamStatistics.defReb),
                _buildStatisticRow('Total Rebounds:', teamStatistics.totReb),
                _buildStatisticRow('Assists:', teamStatistics.assists),
                _buildStatisticRow('Personal Fouls:', teamStatistics.pFouls),
                _buildStatisticRow('Steals:', teamStatistics.steals),
                _buildStatisticRow('Turnovers:', teamStatistics.turnovers),
                _buildStatisticRow('Blocks:', teamStatistics.blocks),
                _buildStatisticRow('Plus-Minus:', teamStatistics.plusMinus),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildStatisticRow(String label, num value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value.toString()),
        ],
      ),
    );
  }
}
