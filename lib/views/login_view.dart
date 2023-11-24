import 'dart:convert';

import 'package:firstproject/views/profil_view.dart';
import 'package:firstproject/views/register_view.dart';
import 'package:flutter/material.dart';

import '../services/authentication_api.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.2),
              Image.asset(
                'assets/logo.png',
                width: 200.0,
                height: 200.0,
              ),
              TextFormField(
                controller: emailController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Adres email',
                    labelStyle: TextStyle(
                      fontFamily: "Bellota-Regular",
                    )),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Hasło',
                    labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  bool success = await login(emailController.text, passwordController.text);
                  if (success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilPage()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Błąd logowania', style: TextStyle(fontFamily: "Bellota-Regular", color: Colors.red),textAlign: TextAlign.center,),
                          content:
                              Text('Nieudane logowanie. Spróbuj ponownie.', style: TextStyle(fontFamily: "Bellota-Regular"),textAlign: TextAlign.center,),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK', textAlign: TextAlign.center, style: TextStyle(fontFamily: "Bellota-Regular")),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
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
                      fontFamily: "Bellota-Regular",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
