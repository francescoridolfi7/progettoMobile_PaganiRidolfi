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
          create: (context) => TeamStatisticsViewModel(
            Provider.of<NbaApi>(context, listen: false),
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TeamListScreen(),
    const StandingsListScreen(),
    const GamesListScreen(),
  ];

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
                _navigateTo(0);
              },
            ),
            ListTile(
              title: const Text('Classifica'),
              onTap: () {
                _navigateTo(1);
              },
            ),
            ListTile(
              title: const Text('Partite'),
              onTap: () {
                _navigateTo(2);
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: const Color.fromARGB(255, 29, 66, 138),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball),
            label: 'Squadre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Classifica',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scoreboard),
            label: 'Partite',
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
      Navigator.pop(context);
    });
  }
}
