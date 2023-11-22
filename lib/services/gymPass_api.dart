import 'dart:convert';

import 'package:firstproject/Model/GymPass.dart';
import 'package:firstproject/Model/GymPassPriceModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GymPassApi{
  Future<GymPass> getPass() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token'); // Zmiana na typ String?

      if (token != null && token.isNotEmpty) {
        //print("$token");
        final response = await http.get(
          Uri.parse('https://localhost:7286/api/GymPass/get'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body)['data'];
          //print('Dane z serwera: $jsonResponse');
          return GymPass.fromJson(jsonResponse);
        } else {
          print("Błąd");
          throw Exception('Failed to gymPass data');
        }
      } else {
        throw Exception('Brak tokenu w SharedPreferences');
      }
    } catch (e) {
      print('Błąd: $e');
      throw Exception('Failed to load qr');
    }
  }

    Future<List<GymPassPrice>> getPassPrices() async {
      List<GymPassPrice> list;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('token'); // Zmiana na typ String?

        if (token != null && token.isNotEmpty) {
          //print("$token");
          final response = await http.get(
            Uri.parse('https://localhost:7286/api/GymPass/prices'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
          );
          if (response.statusCode == 200) {
            var jsonResponse = json.decode(response.body)['data'];
            list = List<GymPassPrice>.from(jsonResponse.map((item) => GymPassPrice.fromJson(item)));
            print('Dane z serwera: $jsonResponse');
            return list;

          } else {
            print("Błąd");
            throw Exception('Failed to gymPass data');
          }
        } else {
          throw Exception('Brak tokenu w SharedPreferences');
        }
      } catch (e) {
        print('Błąd: $e');
        throw Exception('Failed to load qr');
      }

  }

  Future<void> extendPass(int length) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.post(
        Uri.parse('https://localhost:7286/api/GymPass/renew'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(length),
      );

      if (response.statusCode == 200) {
        print('classes add successfully');
      } else {
        print('classes add failed with status: ${response.statusCode}');
        // Tutaj można umieścić logikę obsługi błędu
      }
    } catch (e) {
      print('Error during change classes: $e');
      // Tutaj można umieścić bardziej szczegółową logikę obsługi błędów
    }
  }




}