class UserData {
  final String id;
  final String userName;
  final String fullName;
  final String email;
  final String phoneNumber;

  UserData({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['data']['id'],
      userName: json['data']['userName'],
      fullName: json['data']['fullName'],
      email: json['data']['email'],
      phoneNumber: json['data']['phoneNumber'],
    );
  }
}