import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterBloc {
  Future<bool> registerUser({
    required String userName,
    required String password,
    required String fullName,
    required String email,
    required String phoneNumber,
  }) async {
    var url = Uri.parse('https://localhost:7286/api/Authentication/register');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "userName": userName,
          "password": password,
          "confirmPassword": password,
          "fullName": fullName,
          "email": email,
          "phoneNumber": phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        print("Success");
        return true;
      } else {
        print('Błąd podczas rejestracji. Kod stanu: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Wystąpił błąd: $e');
      return false;
    }
  }

  bool isValidEmail(String email) {
    final emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$';
    final regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    const phonePattern = r'^\d{9,12}$';
    final regex = RegExp(phonePattern);
    return regex.hasMatch(phone);
  }
}
