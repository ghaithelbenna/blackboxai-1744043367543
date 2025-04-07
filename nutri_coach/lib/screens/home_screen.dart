import 'package:flutter/material.dart';
import 'package:nutri_coach/screens/add_meal_screen.dart';
import 'package:nutri_coach/screens/journal_screen.dart';
import 'package:nutri_coach/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NutriCoach'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue dans NutriCoach!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddMealScreen()),
                );
              },
              child: const Text('Ajouter un repas'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JournalScreen(meals: []), // À remplacer par les données réelles
                  ),
                );
              },
              child: const Text('Voir le journal'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: const Text('Profil'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action pour voir les conseils
              },
              child: const Text('Conseils'),
            ),
          ],
        ),
      ),
    );
  }
}