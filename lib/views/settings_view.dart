import 'package:firstproject/views/PersonalInformation_views/editData_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ThemeProvider.dart';
import 'login_view.dart';

class SettingsView extends StatelessWidget {
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  void logout() async {
    await removeToken();
  }

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
              width: 0.9 * MediaQuery.of(context).size.width,
              height: 0.2 * MediaQuery.of(context).size.height,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(); // Przełącz motyw
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.blue;
                    },
                  ),
                ),
                child: Text(
                  'Przełącz motyw',
                  style: TextStyle(
                      fontSize: 0.04 * MediaQuery.of(context).size.height,
                      fontFamily: "Bellota-Regular"),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 0.9 * MediaQuery.of(context).size.width,
              height: 0.2 * MediaQuery.of(context).size.height,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditDataPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.blue;
                    },
                  ),
                ),
                child: Text('Edytuj dane osobiste',
                    style: TextStyle(
                        fontSize: 0.04 * MediaQuery.of(context).size.height,
                        fontFamily: "Bellota-Regular")),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 0.9 * MediaQuery.of(context).size.width,
              height: 0.2 * MediaQuery.of(context).size.height,
              child: ElevatedButton(
                  onPressed: () {
                    logout();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Theme.of(context).brightness == Brightness.dark
                            ? Colors.white12
                            : Colors.red;
                      },
                    ),
                  ),
                  child: Text("Wyloguj się",
                      style: TextStyle(
                          fontSize: 0.05 * MediaQuery.of(context).size.height,
                          fontFamily: "Bellota-Regular"))),
            ),
          ],
        )));
  }
}
