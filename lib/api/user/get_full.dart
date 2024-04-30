import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../controllers/auth_controller.dart';

class fullUserData {
  static Future<Map<String, dynamic>?> fetchUserData(String token) async {
    const url = 'https://api.alphanetverse.com/api/me/';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print('user data fetched');
        final userData = response.body;
        final userMap = json.decode(userData) as Map<String, dynamic>;
        return userMap;
      } else if (response.statusCode == 401) {
        AuthController().logoutUser();

        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
    return null;
  }
}
