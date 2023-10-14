import 'dart:async';

import 'package:firstproject/login_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
@override
_SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Przykładowe opóźnienie na potrzeby symulacji ładowania
    Timer(Duration(seconds: 3), () {
      // Po zakończeniu ekranu ładowania przejście do głównego ekranu
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Kolor tła
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Tutaj możesz dodać niestandardowy widżet, np. logo, animację, tekst ładowania
            Image.asset(
              'assets/logo.png', // Ścieżka do obrazu w projekcie
              width: 500.0,
              height: 500.0,
            ),
            SizedBox(height: 15),
            Text(
              'GymApp',
              style: TextStyle(color: Colors.black, fontSize: 28.0), // Styl tekstu
            ),
          ],
        ),
      ),
    );
  }
}