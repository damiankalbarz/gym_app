import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firstproject/login_view.dart';

final _passwordController = TextEditingController();

void deleteUserAccount(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var response = await http.delete(
      Uri.parse('https://localhost:7286/api/User/delete-account'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(_passwordController.text),
    );

    if (response.statusCode == 200) {
      print('Account deleted successfully');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      print('Account deletion failed with status: ${response.statusCode}');
      // Tutaj możesz dodać obsługę błędów
    }
  } catch (e) {
    print('Error during account deletion: $e');
    // Tutaj możesz dodać bardziej szczegółową obsługę błędów
  }
}

AlertDialog deleteAccount(BuildContext context) {
  return AlertDialog(
    title: Text("Potwierdź usuniecie konta",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Bellota-Regular")),
    actions: <Widget>[
      Column(
        children: [
          Text(
            "Czy na pewno chcesz usunąć swoje konto? Ta operacja jest nieodwracalna.",
            style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Wprowadź hasło w celu usniecia konta",
              style: TextStyle(fontFamily: "Bellota-Regular")),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Hasło',
                labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            obscureText: true,
          ),
          Row(
            children: [
              TextButton(
                child: Text("Anuluj"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      "Usuń konto",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      deleteUserAccount(context);
                      Navigator.of(context).pop(); // Zamknij okno dialogowe
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ],
  );
}
