import 'package:flutter/material.dart';
import 'package:nutri_coach/services/api_service.dart';
import 'package:nutri_coach/services/local_storage.dart';
import 'package:nutri_coach/models/meal.dart';
import 'package:nutri_coach/services/auth_service.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController _mealController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _nutritionData;
  final List<Meal> _meals = [];

  Future<void> _analyzeMeal() async {
    if (_mealController.text.isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      final token = await AuthService().getToken();
      final data = await ApiService.analyzeNutrition(_mealController.text, token);
      setState(() {
        _nutritionData = data;
        _meals.add(Meal(
          description: _mealController.text,
          calories: data['calories'] ?? 0,
          protein: data['protein'] ?? 0,
          carbs: data['carbs'] ?? 0,
          fat: data['fat'] ?? 0,
          date: DateTime.now(),
        ));
      });
      await LocalStorage.saveMeals(_meals);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un repas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _mealController,
              decoration: const InputDecoration(
                labelText: 'Description du repas',
                hintText: 'ex: 100g de poulet grillé avec riz',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _analyzeMeal,
              child: _isLoading 
                  ? const CircularProgressIndicator()
                  : const Text('Analyser'),
            ),
            if (_nutritionData != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Informations nutritionnelles:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Calories: ${_nutritionData?['calories']?.toStringAsFixed(1) ?? '0'} kcal'),
                      const SizedBox(height: 8),
                      Text('Protéines: ${_nutritionData?['protein']?.toStringAsFixed(1) ?? '0'} g'),
                      const SizedBox(height: 8),
                      Text('Glucides: ${_nutritionData?['carbs']?.toStringAsFixed(1) ?? '0'} g'),
                      const SizedBox(height: 8),
                      Text('Lipides: ${_nutritionData?['fat']?.toStringAsFixed(1) ?? '0'} g'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}