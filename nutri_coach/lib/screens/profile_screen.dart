import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  double? _weight;
  double? _height;
  int? _age;
  String? _gender;
  String? _activityLevel;
  String? _goal;
  double? _tdee;

  final List<String> _genders = ['Homme', 'Femme'];
  final List<String> _activityLevels = ['Sédentaire', 'Modéré', 'Actif'];
  final List<String> _goals = ['Perte de poids', 'Maintien', 'Prise de masse'];

  void _calculateTDEE() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Formule Mifflin-St Jeor
      double bmr;
      if (_gender == 'Homme') {
        bmr = 10 * _weight! + 6.25 * _height! - 5 * _age! + 5;
      } else {
        bmr = 10 * _weight! + 6.25 * _height! - 5 * _age! - 161;
      }

      // Facteur d'activité
      double activityFactor;
      switch (_activityLevel) {
        case 'Modéré':
          activityFactor = 1.55;
          break;
        case 'Actif':
          activityFactor = 1.9;
          break;
        default: // Sédentaire
          activityFactor = 1.2;
      }

      setState(() {
        _tdee = bmr * activityFactor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Poids (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Veuillez entrer votre poids';
                  return null;
                },
                onSaved: (value) => _weight = double.tryParse(value!),
              ),
              // Ajouter les autres champs (taille, âge, etc.)
              if (_tdee != null) ...[
                const SizedBox(height: 20),
                Text(
                  'Votre besoin calorique quotidien (TDEE): ${_tdee!.toStringAsFixed(0)} kcal',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
              ElevatedButton(
                onPressed: _calculateTDEE,
                child: const Text('Calculer mon TDEE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}