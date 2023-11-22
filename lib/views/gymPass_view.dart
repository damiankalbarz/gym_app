import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firstproject/Model/GymPass.dart';
import 'package:firstproject/services/gymPass_api.dart';
import 'package:firstproject/views/ExtensionOfGymPass_view.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';
import '../services/gymEntry_api.dart';

class GymPassScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _GymPassState(); // Update the state class name
}

class _GymPassState extends State<GymPassScreen> {
  int _currentIndex = 2;
  late Future<GymPass> gymPass;
  late Uint8List qr;
  double _buttonWidth = 200.0;
  Color _buttonColor = Colors.blue; // Początkowy kolor przycisku
  double ?sideLength;


  void _toggleButton() {
    setState(() {
      _buttonWidth = _buttonWidth == 200.0 ? 300.0 : 200.0;
      _buttonColor = _buttonColor == Colors.blue ? Colors.green : Colors.blue;
    });
  }

  void initState() {
    super.initState();
    // Automatyczna zmiana przycisku co 2 sekundy
    /*Timer.periodic(Duration(seconds: 2), (timer) {
      _toggleButton();
    });*/
    gymPass = GymPassApi().getPass();
  }

  @override
  Widget build(BuildContext context) {
    sideLength ??= MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 0.05 * MediaQuery.of(context).size.height,
            ),
            Center(
              child: Text(
                'TWÓJ KARNET',
                style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 32),
              ),
            ),
            SizedBox(
              height: 0.07 * MediaQuery.of(context).size.height,
            ),
            SizedBox(height: 30),
            FutureBuilder<GymPass>(
              future: gymPass,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String formattedValidTillDay =
                      snapshot.data!.validTill.substring(0, 10);
                  String formattedValidTillHour =
                      snapshot.data!.validTill.substring(11, 19);
                  return Container(
                    child: Column(
                      children: [
                        AnimatedContainer(
                          height: sideLength,
                          width: sideLength,
                          duration: const Duration(milliseconds: 750),
                        child: InkWell(
                          onTap: (){
                            GymEntryApi().addEntry();
                            setState(() {
                              sideLength == MediaQuery.of(context).size.width * 0.7 ? sideLength = MediaQuery.of(context).size.width * 0.85 : sideLength = MediaQuery.of(context).size.width * 0.7;
                            });
                          },
                          child: Image.memory(
                              base64Decode(snapshot.data!.qrCode),
                              //height: MediaQuery.of(context).size.width * 0.7,
                              //width: MediaQuery.of(context).size.width * 0.7
                          ),
                        ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          'Twój karnet jest ważny do:',
                          style: TextStyle(
                              fontSize: 20, fontFamily: "Bellota-Regular"),
                        ),
                        Text(
                          "$formattedValidTillDay $formattedValidTillHour",
                          style: TextStyle(
                              fontSize: 20, fontFamily: "Bellota-Regular"),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
            AnimatedContainer(
                duration: Duration(seconds: 1),
                width: _buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ExtensionOfGymPassPage()));
                  },
                  child: Text(
                    "Przedłuż karnet",
                    style: TextStyle(fontFamily: "Bellota-Regular"),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: _buttonColor, // Zmienny kolor tła przycisku
                    onPrimary: Colors.white, // Kolor tekstu na przycisku
                    padding: EdgeInsets.all(16.0), // Wielkość przycisku
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Zaokrąglenie brzegów
                    ),
                  ),
                )),
          ],
        ),
      ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
