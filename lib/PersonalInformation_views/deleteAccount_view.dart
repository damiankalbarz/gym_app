import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firstproject/views/login_view.dart';

import '../services/user_api.dart';

final _passwordController = TextEditingController();

AlertDialog deleteAccount(BuildContext context) {
  return AlertDialog(
    title: Text("Potwierdź usuniecie konta",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Bellota-Regular")),
    actions: <Widget>[
      Column(
        children: [
          Text(
            "Czy na pewno chcesz usunąć swoje konto? Ta operacja jest nieodwracalna.",
            style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Wprowadź hasło w celu usniecia konta",
              style: TextStyle(fontFamily: "Bellota-Regular")),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Hasło',
                labelStyle: TextStyle(fontFamily: "Bellota-Regular")),
            obscureText: true,
          ),
          Row(
            children: [
              TextButton(
                child: Text("Anuluj"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      "Usuń konto",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      UserApi().deleteUserAccount(context,_passwordController.text);
                      Navigator.of(context).pop(); // Zamknij okno dialogowe
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ],
  );
}
