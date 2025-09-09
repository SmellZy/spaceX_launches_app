import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rockets_app/features/rocket_lauches/rocket_launches_screen.dart';
import 'package:rockets_app/repositories/rocket_launches/rocket_launch.dart';

Future main() async {
  GetIt.I.registerLazySingleton<AbstractRocketLaunchRepository>( () => RocketLaunchesRepository(dio: Dio()));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RocketLaunchesScreen(),
    );
  }
}
