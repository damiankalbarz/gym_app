import 'dart:convert';

import 'package:firstproject/Model/GymEnteryRank.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GymEntryApi{

  Future<void> addEntry() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.post(
        Uri.parse('https://localhost:7286/api/GymEntry/add-entry'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode("20"),
      );

      if (response.statusCode == 200) {
        print('Gym entry added successfully');
      } else {
        print('Gym entry added failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw('Error during added goal: $e');
    }
  }

  Future<List<GymEntryRank>> getEntryRank() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.get(
        Uri.parse('https://localhost:7286/api/GymEntry/get-rank'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body)['data'];
        print(jsonResponse);
        List<GymEntryRank> rank = List<GymEntryRank>.from(jsonResponse.map((item) => GymEntryRank.fromJson(item)));
        print('Rank get successfully');

        return rank;
      } else {
        throw('Rank get failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw('Error during get rank: $e');
    }

  }

  Future<GymEntryRank> getWeekStats() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.get(
        Uri.parse('https://localhost:7286/api/GymEntry/get-week-stats'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body)['data'];
        print('Stats get successfully');
        return GymEntryRank.fromJson(jsonResponse);
      } else {
        print('Stats get failed with status: ${response.statusCode}');
        throw Exception('Stats get failed');
      }
    } catch (e) {

      throw("tats get failed");

    }

  }
}