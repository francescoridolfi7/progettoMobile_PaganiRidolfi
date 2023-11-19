import 'package:flutter/material.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/data/models/nba_team.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/team_details_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/ui/screens/team_list_screen.dart';
import 'package:flutter_application_progettomobile_pagani_ridolfi/view_models/team_list_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TeamListViewModel(),
      child: MaterialApp(
        title: 'NBA Teams',
        initialRoute: '/',
        routes: {
          '/': (context) => const TeamListScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/teamDetails') {
            final team = settings.arguments as NbaTeam;
            return MaterialPageRoute(
              builder: (context) => TeamDetailsScreen(team: team),
            );
          }
          return null;
        },
      ),
    );
  }
}
