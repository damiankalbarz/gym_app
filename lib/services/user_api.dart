import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ProfilPicture.dart';
import '../Model/User.dart';
import 'package:http/http.dart' as http;

import '../views/login_view.dart';

class UserApi {

  final _userController = StreamController<User>();
  Stream<User> get userStream => _userController.stream;
  final _pictureController = StreamController<ProfilePicture>();
  Stream<ProfilePicture> get pictureStream => _pictureController.stream;

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
      } else {
        throw ('Passwor change failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Error during account deletion: $e');
    }
  }

  void sendImageToServer(Uint8List imageBytes) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.put(
        Uri.parse('https://localhost:7286/api/User/change-picture'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(base64Encode(imageBytes)),
      );
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during image upload: $e');
    }
  }

  Future<void> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final response = await http.get(
        Uri.parse('https://localhost:7286/api/User/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var user = User.fromJson(jsonResponse);
        var profilePictureDTO = ProfilePicture.fromJson(jsonResponse);
        _userController.sink.add(user);
        _pictureController.sink.add(profilePictureDTO);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Failed to load user dat $e');
    }
  }

  Future<bool> deleteUserAccount(BuildContext context, String _password) async {
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
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        print('Account deleted successfully');
        return true;
      } else {
        print('Account deletion failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      throw ('Error during account deletion: $e');
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
      } else {
        print('Data change failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw ('Error during account deletion: $e');
    }
  }
}
