

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


final _oldPasswordController = TextEditingController();
final _newPasswordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

AlertDialog changePassword(BuildContext context) {
  return AlertDialog(
    title: Text(
      "Zmiana hasła",
      style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 20),
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      Text(""),
      TextFormField(
        controller: _oldPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Obecne hasło',
            labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
      ),
      SizedBox(
        height: 7,
      ),
      TextFormField(
        controller: _newPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Nowe hasło',
            labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
      ),
      SizedBox(
        height: 7,
      ),
      TextFormField(
        controller: _confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Potwierdź hasło',
            labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Text("Anuluj"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              "Zmień hasło",
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              changePasswordApi();
              Navigator.of(context).pop(); // Zamknij okno dialogowe
            },
          ),
        ],
      ),
    ],
  );
}



void changePasswordApi() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var response = await http.put(
      Uri.parse('https://localhost:7286/api/User/change-password'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
        "currentPassword": _oldPasswordController.text,
        "newPassword": _newPasswordController.text,
        "confirmPassword": _confirmPasswordController.text
      }),
    );

    if (response.statusCode == 200) {
      print('Password change successfully');
      // Tutaj możesz dodać nawigację lub inne działania po usunięciu konta
    } else {
      print('Passwor change failed with status: ${response.statusCode}');
      // Tutaj możesz dodać obsługę błędów
    }
  } catch (e) {
    print('Error during account deletion: $e');
    // Tutaj możesz dodać bardziej szczegółową obsługę błędów
  }
}