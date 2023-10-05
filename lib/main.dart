

import 'package:firstproject/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_view.dart';
import 'profil_view.dart';
import 'navigation.dart';
void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: MyApp(),
      ),
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logowanie',
      theme: ThemeData.light(), // Jasny motyw
      darkTheme: ThemeData.dark(), // Ciemny motyw
      themeMode: Provider.of<ThemeProvider>(context).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: LoginPage(),
    );
  }
}

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
              'assets/logo.jpg', // Ścieżka do obrazu w projekcie
              width: 200.0,
              height: 200.0,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Adres email'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Hasło'),
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
              child: Text('Zaloguj się'),
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
              child: Text('Nie masz jeszcze konta? Zarejestruj się'),
            ),
          ],
        ),
      ),
    );
  }
}

