import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/api/nba_api.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_roster.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/local_storage/database_helper.dart';
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
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfiWeb;

  DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.initializeDatabase();

  runApp(MyApp(dbHelper: dbHelper));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.dbHelper});

  final DatabaseHelper dbHelper;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NbaApi>(
          create: (context) =>
              NbaApi('4315828859msh068310ee9c40e90p1b5d6fjsn973d9e4b1fbb'),
        ),
        Provider<DatabaseHelper>.value(value: dbHelper),
        ChangeNotifierProvider(
          create: (context) => TeamListViewModel(
            Provider.of<DatabaseHelper>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => StandingsViewModel(
            Provider.of<NbaApi>(context, listen: false),
            Provider.of<DatabaseHelper>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => GamesViewModel(
            Provider.of<NbaApi>(context, listen: false),
            Provider.of<DatabaseHelper>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RosterViewModel(
            Provider.of<NbaApi>(context, listen: false),
            Provider.of<DatabaseHelper>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TeamStatisticsViewModel(
            Provider.of<NbaApi>(context, listen: false),
            Provider.of<DatabaseHelper>(context, listen: false),
          ),
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
            final int selectedSeason = arguments['selectedSeason'];

            return MaterialPageRoute(
              builder: (context) => TeamDetailsScreen(
                team: team,
                roster: roster,
                selectedSeason: selectedSeason,
              ),
            );
          } else if (settings.name == '/teamStatistics') {
            final int teamId = settings.arguments as int;
            final int selectedSeason = settings.arguments as int;

            return MaterialPageRoute(
              builder: (context) => TeamStatisticsListScreen(
                teamId: teamId,
                selectedSeason: selectedSeason,
              ),
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
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 29, 66, 138),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'NBA App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Image.asset(
                    'assets/nba_logo.png',
                    height: 80,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            ListTile(
              title: const Text('Lista Squadre'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: const Text('Classifica'),
              onTap: () {
                Navigator.pushNamed(context, '/standings');
              },
            ),
            ListTile(
              title: const Text('Partite'),
              onTap: () {
                Navigator.pushNamed(context, '/games');
              },
            ),
          ],
        ),
      ),
      body: const TeamListScreen(),
    );
  }
}
