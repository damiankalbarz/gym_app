
import 'package:firstproject/Bloc/register_bloc.dart';
import 'package:flutter/material.dart';


import 'login_view.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterBloc _registerBloc = RegisterBloc();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _surenameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 26.0),
              Text('REJESTRACJA',
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
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Imie',
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
                controller: _surenameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Nazwisko',
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
              SizedBox(height: 16.0),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    _fullNameController.text = _nameController.text + " " + _surenameController.text;
                    if (_formKey.currentState!.validate() && _registerBloc.isValidEmail(_emailController.text)&& _registerBloc.isValidPhone(_phoneController.text)) {
                      _registerBloc.registerUser(
                        userName: _userNameController.text,
                        password: _passwordController.text,
                        fullName: _fullNameController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                      ).then((success) {
                        if (success) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Pomyślnie utworzono konto', style: TextStyle(fontFamily: "Bellota-Regular", color: Colors.green),textAlign: TextAlign.center,),
                                content:
                                Text('Teraz zaloguj sie na swoje konto.', style: TextStyle(fontFamily: "Bellota-Regular"),textAlign: TextAlign.center,),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK', textAlign: TextAlign.center, style: TextStyle(fontFamily: "Bellota-Regular")),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }else{
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Błąd rejestracji', style: TextStyle(fontFamily: "Bellota-Regular", color: Colors.red),textAlign: TextAlign.center,),
                                content:
                                Text('Nieudana rejestracja. Spróbuj ponownie.', style: TextStyle(fontFamily: "Bellota-Regular"),textAlign: TextAlign.center,),
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
              TextButton(
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
            ],
          ),
        ),
        ),
      ),

    );
  }
}