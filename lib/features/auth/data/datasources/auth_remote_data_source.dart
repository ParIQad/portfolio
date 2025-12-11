import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  static const String _loginUrl = 'https://dummyjson.com/auth/login';

  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // API returns 400 for invalid credentials
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}