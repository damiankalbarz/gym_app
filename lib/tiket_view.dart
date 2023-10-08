import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'navigation.dart';

class QrCodeScreen extends StatefulWidget {
  final String qrData; // Move the property declaration here

  QrCodeScreen({required this.qrData}); // Initialize the property in the constructor

  @override
  State<StatefulWidget> createState() => _QrCodeScreenState(); // Update the state class name
}

class _QrCodeScreenState extends State<QrCodeScreen> { // Update the state class name
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            ElevatedButton(onPressed: (){}, child: Text("Przedłuż karnet", style: TextStyle(fontFamily: "Bellota-Regular"),))
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
