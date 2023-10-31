import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/ProfilPictureDTO.dart';
import 'Model/User.dart';
import 'Model/Goal.dart';
import 'profil_view.dart';
import 'package:http/http.dart' as http;

class ProfilPageBloc {
  final _userController = StreamController<User>();

  Stream<User> get userStream => _userController.stream;
  final _pictureController = StreamController<ProfilePictureDTO>();

  Stream<ProfilePictureDTO> get pictureStream => _pictureController.stream;

  void dispose() {
    _userController.close();
    _pictureController.close();
  }

  Future<List<Goal>> getGoals() async {
    try {
      List<Goal> goals;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.get(
        Uri.parse('https://localhost:7286/api/TrainingGoal/get-all'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body)['data'];
        print(jsonResponse);
        goals =
            List<Goal>.from(jsonResponse.map((item) => Goal.fromJson(item)));
        print('Goal get successfully');
        //goals.forEach((element) => print(element.content));
        return goals;
      } else {
        print('Goal get failed with status: ${response.statusCode}');
        // Tutaj można umieścić logikę obsługi błędu
      }
    } catch (e) {
      print('Error during get goal: $e');
      // Tutaj można umieścić bardziej szczegółową logikę obsługi błędów
    }
    return [];
  }

  Future<void> addGoals(String goals) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.post(
        Uri.parse('https://localhost:7286/api/TrainingGoal/add'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(goals),
      );

      if (response.statusCode == 200) {
        print('Goal added successfully');
      } else {
        print('Goal added failed with status: ${response.statusCode}');
        // Tutaj można umieścić logikę obsługi błędu
      }
    } catch (e) {
      print('Error during added goal: $e');
      // Tutaj można umieścić bardziej szczegółową logikę obsługi błędów
    }
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
          var profilePictureDTO = ProfilePictureDTO.fromJson(jsonResponse);
          _userController.sink.add(user);
          _pictureController.sink.add(profilePictureDTO);
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
