import 'dart:convert';

import 'package:firstproject/profil_view.dart';
import 'package:firstproject/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_view.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterBloc _registerBloc = RegisterBloc();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  bool isChecked = false;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 26.0),
              const Text('REJESTRACJA',
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Bellota-Regular")),
              SizedBox(height: 26.0),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Nazwa użytkownika',
                    labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pole "Nazwa użytkownika" jest wymagane.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Imie i Nazwisko',
                    labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pole "Nazwisko" jest wymagane.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pole "E-mail" jest wymagane.';
                  }
                  if (!_registerBloc.isValidEmail(value)) {
                    return 'Nieprawidłowy adres email.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Telefon',
                    labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pole "Telefon" jest wymagane.';
                  }
                  if (!_registerBloc.isValidPhone(value)) {
                    return 'Nieprawidłowy numer telefonu.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Hasło',
                    labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pole "Hasło" jest wymagane.';
                  }
                  if (value.length < 8) {
                    return 'Hasło musi mieć co najmniej 8 znaków.';
                  }
                  return null;
                },
                obscureText: true,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: Colors.lightGreenAccent,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text('Akceptuję regulamin',
                    style: TextStyle(fontFamily: "Bellota-Regular"),
                  ),
                ],
              ),
              SizedBox(height: 13.0),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _registerBloc.registerUser(
                        userName: _userNameController.text,
                        password: _passwordController.text,
                        fullName: _fullNameController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                      ).then((success) {
                        if (success) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        }
                      });
                    }
                    },
                  child: Text('Zarejestruj się',
                      style: TextStyle(
                          fontFamily: "Bellota-Regular",
                          fontWeight: FontWeight.w500,
                          fontSize: 30)),
                ),
              ),
              SizedBox(height: 11.0),
              Flexible(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Masz już konto? Zaloguj się',
                    style: TextStyle(
                        fontFamily: "Bellota-Regular",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}