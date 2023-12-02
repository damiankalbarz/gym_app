import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


Future<bool> login(String email, String password) async {
  var url = Uri.parse('https://localhost:7286/api/Authentication/login');
  var body = json.encode({
    'email': email,
    'password': password,
  });

  try {
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      var token = json.decode(response.body)['data'];
      print("login success");
      await saveToken(token);
      return true;
    } else {
      print("login failure");
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

    Future<void> saveToken(String token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

Future<bool> isUserLoggedIn() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('https://localhost:7286/api/User/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }catch(e){
    return false;
  }

}