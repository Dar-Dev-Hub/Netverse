import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../profile/profile_screen.dart';

Future<void> sendPoint(email, amounts) async {
  final box = GetStorage();
  final token = box.read('accessToken');
  try {
    final response = await http.post(
      Uri.parse('https://api.alphanetverse.com/api/transaction/send-points'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        <String, String>{
          'amount': amounts,
          'description': 'Send $amounts Points to $email',
          'receiver': email
        },
      ),
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Points sent successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      );
    } else {
      Get.snackbar(
        'Error',
        'Points not sent',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      );
    }
  } catch (e) {
    print('Error sending points: $e');
  }
}
