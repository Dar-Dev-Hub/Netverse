import 'package:alphanetverse/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgetApi {
  static Future<void> forget(String email) async {
    final url =
        Uri.parse('https://api.alphanetverse.com/api/auth/password-reset/');

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
        },
      );
      print('User after forget : ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final AuthController authController = Get.find();

        await authController.fetchUserData();
        Get.snackbar(
          'Success',
          'Password reset link sent to your email',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        );

        Get.offNamed('/login');
      } else {
        print('forget failed. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during forget: $error');
    }
  }
}
