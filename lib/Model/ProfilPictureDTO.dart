import 'dart:convert';
import 'dart:typed_data';

class ProfilePictureDTO {
  final String id;
  final Uint8List content;
  final DateTime? createdOn;
  final DateTime? updatedOn;

  ProfilePictureDTO({
    required this.id,
    required this.content,
    required this.createdOn,
    required this.updatedOn,
  });

  factory ProfilePictureDTO.fromJson(Map<String, dynamic> json) {
    return ProfilePictureDTO(
      id: json['data']['profilePicture']['id'],
      content: base64Decode(json['data']['profilePicture']['content']),
      createdOn: json['data']['profilePicture']['createdOn'] != null ? DateTime.parse(json['data']['profilePicture']['createdOn']) : null,
      updatedOn: json['data']['profilePicture']['updatedOn'] != null ? DateTime.parse(json['data']['profilePicture']['updatedOn']) : null,
    );
  }
}