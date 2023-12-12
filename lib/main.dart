import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/games_list_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/standings_list_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/team_details_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/team_list_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/teamstatistics_list_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/games_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/roster_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/standings_view_model.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/team_list_view_model.dart';

import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/teamstatistics_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NbaApi>(
          create: (context) =>
              NbaApi('4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb'),
        ),
        ChangeNotifierProvider(
          create: (context) => TeamListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              StandingsViewModel(Provider.of<NbaApi>(context, listen: false)),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              GamesViewModel(Provider.of<NbaApi>(context, listen: false)),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RosterViewModel(Provider.of<NbaApi>(context, listen: false)),
        ),
        ChangeNotifierProvider(
          create: (context) => TeamStatisticsViewModel(Provider.of<NbaApi>(
              context,
              listen: false)), // Aggiunto il nuovo view model
        ),
      ],
      child: MaterialApp(
        title: 'Squadre NBA',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/standings': (context) => const StandingsListScreen(),
          '/games': (context) => const GamesListScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/teamDetails') {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final NbaTeam team = arguments['team'];
            final List<NbaPlayer> roster = arguments['roster'];

            return MaterialPageRoute(
              builder: (context) =>
                  TeamDetailsScreen(team: team, roster: roster),
            );
          } else if (settings.name == '/teamStatistics') {
            // Aggiunto blocco per la nuova schermata
            final int teamId = settings.arguments as int;

            return MaterialPageRoute(
              builder: (context) => TeamStatisticsListScreen(teamId: teamId),
            );
          }
          return null;
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Squadre NBA', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 66, 138),
              ),
              child: Text(
                'NBA App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Team List'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: const Text('Standings'),
              onTap: () {
                Navigator.pushNamed(context, '/standings');
              },
            ),
            ListTile(
              title: const Text('Games'),
              onTap: () {
                Navigator.pushNamed(context, '/games');
              },
            ),
            ListTile(
              title: const Text(
                  'Team Statistics'), // Aggiunto elemento del drawer per la nuova schermata
              onTap: () {
                Navigator.pushNamed(context, '/teamStatistics',
                    arguments:
                        1); // Sostituisci "1" con l'ID del team desiderato
              },
            ),
          ],
        ),
      ),
      body: const TeamListScreen(),
    );
  }
}
