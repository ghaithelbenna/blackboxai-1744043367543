import 'package:flutter/material.dart';
import 'package:nutri_coach/models/meal.dart';
import 'package:nutri_coach/services/local_storage.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<Meal> _meals = [];

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    _meals = await LocalStorage.loadMeals();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Nutritionnel'),
      ),
      body: ListView.builder(
        itemCount: _meals.length,
        itemBuilder: (context, index) {
          final meal = _meals[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(meal.description),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${meal.calories.toStringAsFixed(1)} kcal'),
                  Text('Protéines: ${meal.protein.toStringAsFixed(1)}g'),
                  Text('Glucides: ${meal.carbs.toStringAsFixed(1)}g'),
                  Text('Lipides: ${meal.fat.toStringAsFixed(1)}g'),
                ],
              ),
              trailing: Text(meal.date.toString().substring(0, 10)),
            ),
          );
        },
      ),
    );
  }
}