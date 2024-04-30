import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<void> subTrans(amount, receiver) async {
  final box = GetStorage();
  final token = box.read('accessToken');

  var payload = {
    "amount": '1',
    "description": "Service",
    "receiver": receiver,
  };

  try {
    final response = await http.post(
      Uri.parse('https://api.alphanetverse.com/api/transaction/send-points'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(payload),
    );
    print(json.decode(response.body));
    if (response.statusCode == 201) {
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
