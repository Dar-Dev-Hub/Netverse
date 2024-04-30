import 'dart:convert';
import 'package:alphanetverse/common_widgets/snack_message/snack_message.dart';
import 'package:alphanetverse/controllers/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupApi {
  static Future<void> signUp({
    required BuildContext context,
    required String code,
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String gender, // Add gender parameter
  }) async {
    String apiUrl =
        'https://api.alphanetverse.com/api/auth/register/${code.toString()}';

    String userCountry = await LocationService.getUserCountry();

    final Map<String, dynamic> userData = {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "role": "User",
      "password": password,
      "country": userCountry,
      "gender": gender, // Include gender in the request payload
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    print(response.body);
    final res = json.decode(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      // Successful signup
      print('Signup successful');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomSnackBarContent(
            title: 'Success',
            message: 'Signup successful. Please login.',
            bgcolor: Colors.green,
            bubcolor: Color.fromARGB(255, 0, 114, 4),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      Get.offNamed('/login');
    }
    if (response.statusCode == 400) {
      // Failed signup
      print('Signup failed: ${res['errors'][0]['detail']}');
      final message = res['errors'][0]['detail'];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackBarContent(
            title: 'Error',
            message: message,
            bgcolor: Colors.red,
            bubcolor: Color.fromARGB(255, 131, 35, 28),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    } else {
      // Failed signup
      print('Signup failed: ${response.reasonPhrase}');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: CustomSnackBarContent(
      //       title: 'Error',
      //       message: 'Signup failed.',
      //       bgcolor: Colors.red,
      //       bubcolor: Color.fromARGB(255, 131, 35, 28),
      //     ),
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //   ),
      // );
    }
  }
}
