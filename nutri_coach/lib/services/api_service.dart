import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000'; // Pour émulateur Android

  static Future<Map<String, dynamic>> analyzeNutrition(String text, String? token) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      
      final response = await http.post(
        Uri.parse('$baseUrl/analyze'),
        headers: headers,
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'calories': data['calories']?.toDouble() ?? 0.0,
          'protein': data['protein']?.toDouble() ?? 0.0,
          'carbs': data['carbs']?.toDouble() ?? 0.0,
          'fat': data['fat']?.toDouble() ?? 0.0,
        };
      } else {
        throw Exception('Failed to analyze nutrition: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }
}