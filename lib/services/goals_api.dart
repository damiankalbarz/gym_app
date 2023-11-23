import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Model/Goal.dart';

class GoalsApi {

  Future<void> addGoals(String goals) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.post(
        Uri.parse('https://localhost:7286/api/TrainingGoal/add'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(goals),
      );

      if (response.statusCode == 200) {
        print('Goal added successfully');
      } else {
        print('Goal added failed with status: ${response.statusCode}');
        // Tutaj można umieścić logikę obsługi błędu
      }
    } catch (e) {
      print('Error during added goal: $e');
      // Tutaj można umieścić bardziej szczegółową logikę obsługi błędów
    }
  }

  Future<void> toggle(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.put(
        Uri.parse('https://localhost:7286/api/TrainingGoal/{$id}/toggle'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        print('toggle change successfully');
      } else {
        throw('toggle added failed with status: ${response.statusCode}');

      }
    } catch (e) {
      throw('Error during change toggle: $e');

    }
  }

  Future<void> deleteGoal(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.delete(
        Uri.parse('https://localhost:7286/api/TrainingGoal/{$id}/delete'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        print('toggle delete successfully');
      } else {
        throw('toggle added failed with status: ${response.statusCode}');

      }
    } catch (e) {
      throw('Error during change toggle: $e');

    }
  }


  Future<List<Goal>> getGoals() async {
    try {
      List<Goal> goals;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.get(
        Uri.parse('https://localhost:7286/api/TrainingGoal/get-all'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body)['data'];
        goals = List<Goal>.from(jsonResponse.map((item) => Goal.fromJson(item)));
        print('Goal get successfully');
        return goals;
      } else {
        throw('Goal get failed with status: ${response.statusCode}');

      }
    } catch (e) {
      throw('Error during get goal: $e');
    }

  }
}