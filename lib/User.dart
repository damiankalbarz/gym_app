import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String id;
  final String userName;
  final String fullName;
  final String email;



  User({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.email,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['data']['id'],
      userName: json['data']['userName'],
      fullName: json['data']['fullName'],
      email: json['data']['email'],
    );
  }
}