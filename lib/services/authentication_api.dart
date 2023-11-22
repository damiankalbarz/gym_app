import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  return token != null && token.isNotEmpty;
}
