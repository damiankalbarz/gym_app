import 'package:firstproject/profil_view.dart';
import 'package:firstproject/register_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
              decoration: InputDecoration(
                  labelText: 'Adres email',
                  labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Hasło',
                  labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Tutaj można dodać logikę logowania
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilPage(),
                  ),
                );
              },
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
