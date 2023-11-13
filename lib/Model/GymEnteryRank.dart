import 'dart:convert';
import 'dart:typed_data';

class GymEntryRank{
  final String profileId;
  final String userName;
  final Uint8List profilePicture;
  final int numberOfEntries;
  final String timeSpend;

  GymEntryRank({
  required this.profileId,
  required this.userName,
  required this.profilePicture,
  required this.numberOfEntries,
  required this.timeSpend});

  factory GymEntryRank.fromJson(Map<String,dynamic> json){
    return GymEntryRank(
        profileId: json['profileId'],
        userName: json['userName'],
        profilePicture: base64Decode(json['profilePicture']),
        numberOfEntries: json['numberOfEntries'],
        timeSpend: json['timeSpent']);
  }
}