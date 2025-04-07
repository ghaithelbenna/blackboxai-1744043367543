import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:nutri_coach/models/meal.dart';

class LocalStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/meals.json');
  }

  static Future<List<Meal>> loadMeals() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(contents);
        return jsonList.map((json) => Meal.fromJson(json)).toList();
      }
    } catch (e) {
      print('Erreur de lecture: $e');
    }
    return [];
  }

  static Future<void> saveMeals(List<Meal> meals) async {
    try {
      final file = await _localFile;
      final jsonList = meals.map((meal) => meal.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList));
    } catch (e) {
      print('Erreur de sauvegarde: $e');
    }
  }
}