import 'dart:convert';

import 'package:firstproject/profil_view.dart';
import 'package:firstproject/register_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    var url = Uri.parse('https://example.com/login'); // Zastąp adresem swojego serwera logowania
    var body = json.encode({
      'username': emailController.text,
      'password': passwordController.text,
    });

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      // Zalogowano pomyślnie, przekieruj na główny ekran
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilPage()),
      );
    } else {
      // Obsługa błędów logowania
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Błąd logowania'),
            content: Text('Nieudane logowanie. Spróbuj ponownie.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Ścieżka do obrazu w projekcie
              width: 200.0,
              height: 200.0,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Adres email',
                  labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Hasło',
                  labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Zaloguj się',
                  style: TextStyle(fontFamily: "Bellota-Regular")),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              child: Text(
                'Nie masz jeszcze konta? Zarejestruj się',
                style: TextStyle(
                    fontFamily: "Bellota-Regular", fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
