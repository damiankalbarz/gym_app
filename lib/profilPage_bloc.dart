import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/User.dart';
import 'profil_view.dart';
import 'package:http/http.dart' as http;

class ProfilPageBloc {
  final _userController = StreamController<User>();
  Stream<User> get userStream => _userController.stream;

  void dispose() {
    _userController.close();
  }

  Future<void> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token'); // Zmiana na typ String?

      if (token != null && token.isNotEmpty) {
        //print("$token");
        final response = await http.get(
          Uri.parse('https://localhost:7286/api/User/profile'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          //print('Dane z serwera: $jsonResponse');
          var user = User.fromJson(jsonResponse);
          _userController.sink.add(user);
        } else {
          print("Błąd");
          throw Exception('Failed to load user data');
        }
      } else {
        throw Exception('Brak tokenu w SharedPreferences');
      }
    } catch (e) {
      print('Błąd: $e');
      throw Exception('Failed to load user data');
    }
  }

}
