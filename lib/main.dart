import 'package:firstproject/ThemeProvider.dart';
import 'package:firstproject/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Upewnij się, że Flutter został zainicjalizowany
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false; // Odczytaj stan motywu
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(isDarkMode),
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
