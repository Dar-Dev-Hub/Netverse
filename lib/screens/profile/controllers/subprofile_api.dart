import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<void> subProfile(name, code) async {
  final box = GetStorage();
  final token = box.read('accessToken');

  var payload = {
    "name": name,
    "voucher_code": code,
  };

  try {
    final response = await http.post(
      Uri.parse('https://api.alphanetverse.com/api/sub-account/create/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(payload),
    );
    print(json.decode(response.body));
    if (response.statusCode == 201) {
      code = (json.decode(response.body));
      print(code);

      Get.snackbar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
        'Success',
        'Sub Profile created scuccessfully',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      Get.snackbar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
        'Error',
        'Sub Profile not purchased',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (error) {
    throw Exception(error);
  }
}
