import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../navigation.dart';

class QrCodeScreen extends StatefulWidget {
  final String qrData; // Move the property declaration here

  QrCodeScreen(
      {required this.qrData}); // Initialize the property in the constructor

  @override
  State<StatefulWidget> createState() =>
      _QrCodeScreenState(); // Update the state class name
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  // Update the state class name
  int _currentIndex = 2;
  double _buttonWidth = 200.0;
  Color _buttonColor = Colors.blue; // Początkowy kolor przycisku
  void _toggleButton() {
    setState(() {
      // Zmiana szerokości i koloru przycisku
      _buttonWidth = _buttonWidth == 200.0 ? 300.0 : 200.0;
      _buttonColor = _buttonColor == Colors.blue ? Colors.green : Colors.blue;
    });
  }

  void initState() {
    super.initState();
    // Automatyczna zmiana przycisku co 2 sekundy
    Timer.periodic(Duration(seconds: 2), (timer) {
      _toggleButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'TWÓJ KARNET',
                style: TextStyle(fontFamily: "Bellota-Regular", fontSize: 32),
              ),
            ),
            SizedBox(height: 30),
            QrImageView(
              backgroundColor: Colors.white,
              data: widget.qrData, // Access the qrData property using widget
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            Text(
              'Twój karnet jest ważny do:',
              style: TextStyle(fontSize: 20, fontFamily: "Bellota-Regular"),
            ),
            SizedBox(height: 10),
            SelectableText(
              widget.qrData, // Access the qrData property using widget
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            AnimatedContainer(
                duration: Duration(seconds: 1),
                width: _buttonWidth,
                child: ElevatedButton(
                  onPressed: () {},
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
