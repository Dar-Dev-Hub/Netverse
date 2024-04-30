import 'dart:convert';

import 'package:alphanetverse/api/user/get_full.dart';
import 'package:alphanetverse/controllers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:io' show Platform;

class AuthController extends GetxController {
  final box = GetStorage();
  var isLoggedIn = false.obs;
  var user = {}.obs;
  String accessToken = '';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  AuthController() {
    String os = Platform.operatingSystem; //in your code
    box.write("os", os);
    isLoggedIn.value = box.read('isLoggedIn') ?? false;
    if (isLoggedIn.value == true) {
      fetchUserData();
    }
  }

  void setAccessToken(String token) {
    box.write('accessToken', token);
    accessToken = token;
  }

  void setRefreshToken(String token) {
    box.write('refreshToken', token);
  }

  void setLoggedIn(bool status) {
    isLoggedIn.value = status;
    print(isLoggedIn.value);
    box.write('isLoggedIn', status);
  }

  void logoutUser() async {
    final token = box.read('accessToken');
    await http.delete(
        Uri.parse('https://api.alphanetverse.com/api/me/my-device/'),
        headers: {
          'Authorization': 'Bearer $token',
        });
    await GetStorage().erase();
    isLoggedIn.value = false;
    user.value = {};

    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();

    Get.offAllNamed('/login');
  }

  Future<void> fetchUserData() async {
    final token = box.read('accessToken');
    print(token);

    isLoggedIn.value = box.read('isLoggedIn') ?? false;

    if (token != null && isLoggedIn.value) {
      final userData = await fullUserData.fetchUserData(token);
      if (userData != null) {
        user.value = userData;
        print('Isinde fetchUserData: $userData');
        box.write('user', userData);

        firstNameController.text = userData['first_name'] ?? '';
        lastNameController.text = userData['last_name'] ?? '';
        emailController.text = userData['email'] ?? '';
        phoneController.text = userData['phone'] ?? '';
      }
    } else {
      print('Access token not found or user is not logged in');
    }
  }

  void deleteUser() async {
    final token = box.read('accessToken');
    print(token);
    try {
      final response = await http.delete(
        Uri.parse('https://api.alphanetverse.com/api/me/delete'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        print('User deleted successfully');
        logoutUser();
      } else {
        print('User deletion failed. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during user deletion: $error');
    }
  }

  void checkTokenValidityAndRefresh() async {
    final token = box.read('accessToken');

    if (token != null && JwtDecoder.isExpired(token)) {
      final refreshToken = box.read('refreshToken');

      if (refreshToken != null) {
        final refreshUrl =
            Uri.parse('https://api.alphanetverse.com/api/auth/jwt/verify/');
        try {
          final refreshResponse = await http.post(
            refreshUrl,
            body: {'refresh': refreshToken},
          );

          if (refreshResponse.statusCode == 200) {
            final Map<String, dynamic> responseData =
                json.decode(refreshResponse.body);
            final String newAccessToken = responseData['access'];
            setAccessToken(newAccessToken);

            await fetchUserData();
          } else {
            print(
                'Token refresh failed. Status code: ${refreshResponse.statusCode}');
            logoutUser();
          }
        } catch (error) {
          print('Error during token refresh: $error');
          logoutUser();
        }
      } else {
        print('Refresh token not found');
        logoutUser();
      }
    }
  }
}
