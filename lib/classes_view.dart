import 'package:flutter/material.dart';

import 'navigation.dart';

class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  TextEditingController imieController = TextEditingController();
  TextEditingController nazwiskoController = TextEditingController();
  bool zapisano = false;
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zapis na siłownię'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: imieController,
              decoration: InputDecoration(labelText: 'Imię'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nazwiskoController,
              decoration: InputDecoration(labelText: 'Nazwisko'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tutaj można dodać kod do zapisywania użytkownika na zajęcia.
                setState(() {
                  zapisano = true;
                });
              },
              child: Text('Zapisz się'),
            ),
            SizedBox(height: 20),
            zapisano
                ? Text(
              'Zapisano na zajęcia!',
              style: TextStyle(fontSize: 18, color: Colors.green),
            )
                : Container(),
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