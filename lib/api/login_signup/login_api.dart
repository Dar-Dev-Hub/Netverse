import 'dart:io';

import 'package:alphanetverse/controllers/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApi {
  static Future<void> login(String email, String password) async {
    final url = Uri.parse('https://api.alphanetverse.com/api/auth/jwt/');

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String accessToken = responseData['access'];
        final String refreshToken = responseData['refresh'];

        final AuthController authController = Get.find();
        authController.setAccessToken(accessToken);
        authController.setRefreshToken(refreshToken);

        authController.setLoggedIn(true);

        await authController.fetchUserData();
        final firebaseMessaging = FirebaseMessaging.instance;
        final FCMToken = await firebaseMessaging.getToken();
        print('FCMM: $FCMToken');
        print('Device type: ${Platform.operatingSystem}');

        Get.offNamed('/drawer');

        final deviceType =
            Platform.operatingSystem == 'android' ? 'android' : 'ios';
        final deviceData = {
          'registration_id': FCMToken,
          'type': deviceType,
          'active': true.toString(),
        };
        final deviceResponse = await http.post(
          Uri.parse('https://api.alphanetverse.com/api/me/my-device/'),
          headers: {'Authorization': 'Bearer $accessToken'},
          body: deviceData,
        );
        if (deviceResponse.statusCode == 201) {
          print('done');
        } else if (deviceResponse.statusCode == 204) {
          final deviceResponse = await http.put(
            Uri.parse('https://api.alphanetverse.com/api/me/my-device/'),
            headers: {'Authorization': 'Bearer $accessToken'},
            body: deviceData,
          );
          if (deviceResponse.statusCode == 200) {
            print('done');
          } else {
            print(
                'Error during device registration: ${deviceResponse.statusCode}');
          }
        } else {
          print(
              'Error during device registration: ${deviceResponse.statusCode}');
        }
        print('done');
      } else {
        print('Login failed. Status code: ${response.statusCode}');
        Get.snackbar(
            duration: Duration(seconds: 1),
            'Error',
            'Login failed. Check your email and password',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
      }
    } catch (error) {
      print('Error during login: $error');
    }
  }
}
