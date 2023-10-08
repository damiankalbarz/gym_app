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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 0.9*MediaQuery.of(context).size.width,
              height: 0.2*MediaQuery.of(context).size.height,
              child:  ElevatedButton(
                onPressed: () {
                  themeProvider.toggleTheme(); // Przełącz motyw
                },
                child: Text('Przełącz motyw', style: TextStyle(fontSize: 0.04 * MediaQuery.of(context).size.height, fontFamily: "Bellota-Regular"),),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 0.9*MediaQuery.of(context).size.width,
              height: 0.2*MediaQuery.of(context).size.height,
              child:  ElevatedButton(
                onPressed: () {
                },
                child: Text('Edytuj dane osobiste',style: TextStyle(fontSize: 0.04 * MediaQuery.of(context).size.height, fontFamily: "Bellota-Regular")),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 0.9*MediaQuery.of(context).size.width,
              height: 0.2*MediaQuery.of(context).size.height,
              child:  ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);},
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text("Wyloguj się", style: TextStyle(fontSize: 0.05 * MediaQuery.of(context).size.height, fontFamily: "Bellota-Regular"))),

            ),
          ],
        )
      )

    /*Padding(
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
      ),*/
    );
  }
}
