import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ThemeProvider.dart';
import 'main.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ustawienia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child:Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                }, child: Text("Wyloguj się", style: TextStyle(fontSize: 30, color: Colors.black26),),),],
    ),
      ),),
            Card(
              child: ElevatedButton(
                onPressed: () {
                  themeProvider.toggleTheme(); // Przełącz motyw
                },
                child: Text('Przełącz motyw'),
              ),
            )

          ],
        )
      ),
    );
  }
}
