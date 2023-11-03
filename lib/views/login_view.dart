import 'dart:convert';

import 'package:firstproject/views/profil_view.dart';
import 'package:firstproject/views/register_view.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginBloc _loginBloc = LoginBloc();

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
                controller: _loginBloc.emailController,
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
                controller: _loginBloc.passwordController,
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
                  bool success = await _loginBloc.login();
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
                          title: Text('Błąd logowania'),
                          content:
                              Text('Nieudane logowanie. Spróbuj ponownie.'),
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
