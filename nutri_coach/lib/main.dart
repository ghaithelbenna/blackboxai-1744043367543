import 'package:flutter/material.dart';
import 'package:nutri_coach/screens/home_screen.dart';

void main() {
  runApp(const NutriCoachApp());
}

class NutriCoachApp extends StatelessWidget {
  const NutriCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriCoach',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}