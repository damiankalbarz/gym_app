import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';

import 'package:firstproject/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

AlertDialog changePersonalInformation(BuildContext context) {
  return AlertDialog(
    title: Text(
      "Edycja danych personalnych",
      style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 20),
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      Column(
        children: [
          Text(
            "Nazwa Użytkownika",
            style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),
          ),
          SizedBox(
            height: 2,
          ),
          TextFormField(
            //controller: _oldPasswordController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Pawian123',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Imie i Nazwisko",
            style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),
          ),
          SizedBox(
            height: 2,
          ),
          TextFormField(
            //controller: _oldPasswordController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Jarek Nowak',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Email",
            style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),
          ),
          SizedBox(
            height: 2,
          ),
          TextFormField(
            //controller: _oldPasswordController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Jarus@gmail.com',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Telefon Komórkowy",
            style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 14),
          ),
          SizedBox(
            height: 2,
          ),
          TextFormField(
            //controller: _oldPasswordController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: '666222111',
              labelStyle: TextStyle(fontFamily: "Bellota-Regular"),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
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
                  margin: EdgeInsets.all(8.0),
                  child: TextButton(
                    child: Text(
                      "Zatwierdź zmiany",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      //changePasswordApi();
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
