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
      id: json['id'],
      content: base64Decode(json['content']),
      createdOn: json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null,
      updatedOn: json['updatedOn'] != null ? DateTime.parse(json['updatedOn']) : null,
    );
  }
}