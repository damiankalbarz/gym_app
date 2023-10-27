import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ProfilPictureDTO.dart';

class User {
  final String id;
  final String userName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final ProfilePictureDTO profilePicture;


  User({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['data']['user']['id'],
      userName: json['data']['user']['userName'],
      fullName: json['data']['user']['fullName'],
      email: json['data']['user']['email'],
      phoneNumber: json['data']['user']['phoneNumber'],
      profilePicture: ProfilePictureDTO.fromJson(json['data']['profilePictureDTO']),
    );
  }
}