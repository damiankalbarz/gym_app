import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ProfilPictureDTO.dart';
import '../Model/User.dart';
import 'package:http/http.dart' as http;

import '../views/login_view.dart';

class UserApi {
  final _userController = StreamController<User>();

  Stream<User> get userStream => _userController.stream;
  final _pictureController = StreamController<ProfilePictureDTO>();

  Stream<ProfilePictureDTO> get pictureStream => _pictureController.stream;

  void dispose() {
    _userController.close();
    _pictureController.close();
  }

  void changePasswordApi(
      String _oldPassword, String _newPassword, String _confirmPassword) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.put(
        Uri.parse('https://localhost:7286/api/User/change-password'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "currentPassword": _oldPassword,
          "newPassword": _newPassword,
          "confirmPassword": _confirmPassword
        }),
      );

      if (response.statusCode == 200) {
        print('Password change successfully');
        // Tutaj możesz dodać nawigację lub inne działania po usunięciu konta
      } else {
        print('Passwor change failed with status: ${response.statusCode}');
        // Tutaj możesz dodać obsługę błędów
      }
    } catch (e) {
      print('Error during account deletion: $e');
      // Tutaj możesz dodać bardziej szczegółową obsługę błędów
    }
  }

  void sendImageToServer(Uint8List imageBytes) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token'); // Zmiana na typ String?
      //print(byteString.length);
      var response = await http.put(
        Uri.parse('https://localhost:7286/api/User/change-picture'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(base64Encode(imageBytes!)),
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        // Tutaj można umieścić logikę obsługi sukcesu
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        // Tutaj można umieścić logikę obsługi błędu
      }
    } catch (e) {
      print('Error during image upload: $e');
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

  void deleteUserAccount(BuildContext context, String _password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.delete(
        Uri.parse('https://localhost:7286/api/User/delete-account'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(_password),
      );

      if (response.statusCode == 200) {
        print('Account deleted successfully');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        print('Account deletion failed with status: ${response.statusCode}');
        // Tutaj możesz dodać obsługę błędów
      }
    } catch (e) {
      print('Error during account deletion: $e');
      // Tutaj możesz dodać bardziej szczegółową obsługę błędów
    }
  }

  void changePersonalInformation(
      String _phoneNumber, String _fullName, String _email) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.put(
        Uri.parse('https://localhost:7286/api/User/change-profile-data'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "phoneNumber": _phoneNumber,
          "fullName": _fullName,
          "email": _email
        }),
      );

      if (response.statusCode == 200) {
        print('Data change successfully');
        // Tutaj możesz dodać nawigację lub inne działania po usunięciu konta
      } else {
        print('Data change failed with status: ${response.statusCode}');
        // Tutaj możesz dodać obsługę błędów
      }
    } catch (e) {
      print('Error during account deletion: $e');
      // Tutaj możesz dodać bardziej szczegółową obsługę błędów
    }
  }
}
