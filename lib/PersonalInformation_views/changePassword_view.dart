

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../services/user_api.dart';


final _oldPasswordController = TextEditingController();
final _newPasswordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

AlertDialog changePassword(BuildContext context) {
  return AlertDialog(
    title: Text(
      "Zmiana hasła",
      style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 20),
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      Text(""),
      TextFormField(
        controller: _oldPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Obecne hasło',
            labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
      ),
      SizedBox(
        height: 7,
      ),
      TextFormField(
        controller: _newPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Nowe hasło',
            labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
      ),
      SizedBox(
        height: 7,
      ),
      TextFormField(
        controller: _confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Potwierdź hasło',
            labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Text("Anuluj"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              "Zmień hasło",
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              UserApi().changePasswordApi(_oldPasswordController.text,_newPasswordController.text,_confirmPasswordController.text);
              Navigator.of(context).pop(); // Zamknij okno dialogowe
            },
          ),
        ],
      ),
    ],
  );
}



