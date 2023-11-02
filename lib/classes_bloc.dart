import 'dart:convert';

import 'package:firstproject/Model/PersonalTrainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<PersonalTrainer>> getTrainer() async {
  try {
    List<PersonalTrainer> trainer;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var response = await http.get(
      Uri.parse('https://localhost:7286/api/PersonalTrainer/get-all'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['data'];
      trainer = List<PersonalTrainer>.from(jsonResponse.map((item) => PersonalTrainer.fromJson(item)));
      print('Treiner get successfully');
      print(jsonResponse);
      return trainer;
    } else {
      print('Treiner get failed with status: ${response.statusCode}');
      // Tutaj można umieścić logikę obsługi błędu
    }
  } catch (e) {
    print('Error during get trainer: $e');
    // Tutaj można umieścić bardziej szczegółową logikę obsługi błędów
  }
  return [];
}