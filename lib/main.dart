import 'package:firstproject/ThemeProvider.dart';
import 'package:firstproject/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logowanie',
      theme: ThemeData.light(),
      // Jasny motyw
      darkTheme: ThemeData.dark(),
      // Ciemny motyw
      themeMode: Provider.of<ThemeProvider>(context).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
