import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // The URL for the fake API
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Function to send the message
  static Future<bool> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        // We tell the server we are sending JSON data
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // We convert our Dart data into JSON format
        body: jsonEncode(<String, dynamic>{
          'title': 'Portfolio Contact', // Fake title required by API
          'body': message, // The actual message
          'userId': 1, // Fake user ID
        }),
      );

      // Status code 201 means "Created" (Success)
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // If internet fails
      return false;
    }
  }
}
