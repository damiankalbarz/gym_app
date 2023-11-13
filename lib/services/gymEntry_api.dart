import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GymEntryApi{

  Future<void> addEntry() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await http.post(
        Uri.parse('https://localhost:7286/api/GymEntry/add-entry'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: 0,
      );

      if (response.statusCode == 200) {
        print('Gym entry added successfully');
      } else {
        print('Gym entry added failed with status: ${response.statusCode}');
        // Tutaj można umieścić logikę obsługi błędu
      }
    } catch (e) {
      print('Error during added goal: $e');
      // Tutaj można umieścić bardziej szczegółową logikę obsługi błędów
    }
  }

}