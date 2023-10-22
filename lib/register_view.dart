import 'dart:convert';

import 'package:firstproject/profil_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  /*
  Future<void> registerUser(BuildContext context) async {
    var url = Uri.parse('https://localhost:7286/api/Authentication/register');
    try {
      var response = await http.post(url, body: {
        "userName": _userNameController.text,
        "password": _passwordController.text,
        "confirmPassword": _passwordController.text,
        "fullName": _fullNameController.text,
        "email": _emailController.text,
        "phoneNumber": _phoneController.text
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilPage()),
        );
      } else {
        if (response.statusCode == 400) {
          // Obsługa błędów 400 Bad Request
          var errorResponse = json.decode(response.body);
          String errorMessage = errorResponse['message'];
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Błąd rejestracji"),
                content: Text(errorMessage),
                actions: [
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
        } else {
          // Inne kody stanu HTTP
          throw Exception('Failed to register user. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Obsługa innych błędów, takich jak problemy z połączeniem
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Błąd"),
            content: Text("Wystąpił problem podczas połączenia z serwerem."),
            actions: [
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

   */

  Future<void> registerUser() async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse('https://localhost:7286/api/Authentication/register');
    try {
      var response = await http.post(url, headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
        "userName": _userNameController.text,
        "password": _passwordController.text,
        "confirmPassword": _passwordController.text,
        "fullName": _fullNameController.text,
        "email": _emailController.text,
        "phoneNumber": _phoneController.text
      }));

      if (response.statusCode == 200) {
        // Rejestracja zakończona sukcesem
        // Możesz tutaj dodać odpowiednią obsługę sukcesu, na przykład przenieść użytkownika do innej strony
        print('Pomyślnie zarejestrowano użytkownika');
      } else {
        // Obsługa błędów
        print('Błąd podczas rejestracji. Kod stanu: ${response.statusCode}');
      }
    } catch (e) {
      // Obsługa innych błędów, takich jak problemy z połączeniem
      print('Wystąpił błąd: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  bool isChecked = false;

  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$';
    final regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    final phonePattern = r'^\d{9,12}$';
    final regex = RegExp(phonePattern);
    return regex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    labelText: 'E-mail',
                    labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pole "E-mail" jest wymagane.';
                  }
                  if (!_isValidEmail(value)) {
                    return 'Nieprawidłowy adres email.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                    labelText: 'Telefon',
                    labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pole "Telefon" jest wymagane.';
                  }
                  if (!_isValidPhone(value)) {
                    return 'Nieprawidłowy numer telefonu.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
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
                  Text(
                    'Akceptuję regulamin',
                    style: TextStyle(fontFamily: "Bellota-Regular"),
                  ),
                ],
              ),
              SizedBox(height: 13.0),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
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
