import 'package:flutter/material.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medics',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SplashScreen(), // Змініть на SplashScreen
    );
  }
}