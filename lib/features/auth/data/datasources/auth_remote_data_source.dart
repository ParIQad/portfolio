import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  static const String _loginUrl = 'https://dummyjson.com/auth/login';
  static const String _userUrl = 'https://dummyjson.com/users';

  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
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

  /// Simulate logout by calling DELETE user endpoint (mock)
  /// DummyJSON doesn't have a real logout endpoint, so we use
  /// DELETE /users/{id} to simulate server-side session invalidation.
  Future<bool> logout(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_userUrl/$userId'),
      );

      // DummyJSON returns 200 with isDeleted: true for successful delete
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['isDeleted'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
