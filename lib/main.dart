import 'package:flutter/material.dart';
import 'package:rockets_app/features/rocket_lauches/rocket_launches_screen.dart';
import 'package:rockets_app/repositories/rocket_launches/rocket_launches_repository.dart';

Future main() async{
  RocketLaunchesRepository().getLaunches;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RocketLaunchesScreen()
    );
  }
}
