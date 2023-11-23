
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ListClassModel.dart';
import 'package:http/http.dart' as http;

import '../Model/PersonalTrainer.dart';

class ClassesApi {

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
        trainer = List<PersonalTrainer>.from(
            jsonResponse.map((item) => PersonalTrainer.fromJson(item)));
        print('Treiner get successfully');
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


  Future<List<ListClassModel>> getClasses() async {
    try {
      List<ListClassModel> classes;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.get(
        Uri.parse('https://localhost:7286/api/Class/users-classes'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body)['data'];
        classes = List<ListClassModel>.from(
            jsonResponse.map((item) => ListClassModel.fromJson(item)));
        print('classes get successfully');
        return classes;
      } else {
        throw('classes get failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw('Error during get goal: $e');

    }

  }

  Future<void> addClasses(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.post(
        Uri.parse('https://localhost:7286/api/Class/{$id}/assign-to-user'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        print('classes add successfully');
      } else {
        print('classes add failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw('Error during change classes: $e');
    }
  }

  Future<void> deleteClasses(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.post(
        Uri.parse('https://localhost:7286/api/Class/{$id}/unassign-from-user'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        print('classes delete successfully');
      } else {
        print('classes delete failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw('Error during delete classes: $e');
    }
  }
}
