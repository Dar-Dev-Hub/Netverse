import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<void> voucherPurchased() async {
  final box = GetStorage();
  final token = box.read('accessToken');
  final code;

  try {
    final response = await http.post(
      Uri.parse('https://api.alphanetverse.com/api/vouchers/purchase/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 201) {
      code = (json.decode(response.body));
      print(code);
      box.write('voucherCode', code['code']);
      Get.snackbar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
        'Success',
        'Voucher purchased scuccessfully',
        snackPosition: SnackPosition.TOP,
      );
      print(response.body);
    } else {
      Get.snackbar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
        'Error',
        'Voucher not purchased',
        snackPosition: SnackPosition.BOTTOM,
      );
      print(response.body);
    }
  } catch (error) {
    throw Exception(error);
  }
}

Future<void> voucherSub(code) async {
  final box = GetStorage();
  final token = box.read('accessToken');

  try {
    final response = await http.put(
      Uri.parse('https://api.alphanetverse.com/api/vouchers/$code/to_current/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
        'Success',
        'Voucher purchased scuccessfully',
        snackPosition: SnackPosition.TOP,
      );
      await http.put(
        Uri.parse(
            'https://api.alphanetverse.com/api/vouchers/$code/to_current/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
    } else {
      Get.snackbar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
        'Error',
        'Voucher not purchased',
        snackPosition: SnackPosition.BOTTOM,
      );
      print(response.body);
    }
  } catch (error) {
    throw Exception(error);
  }
}

Future<dynamic> toOwned(code) async {
  final box = GetStorage();
  final token = box.read('accessToken');

  try {
    final response = await http.put(
      Uri.parse('https://api.alphanetverse.com/api/vouchers/$code/to_owned/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      await sendVoucherToCurrent(code);
      return json.decode(response.body);
      //box.write('voucherCode', json.decode(response.body)['code']);
      //box.write('voucherCode', code['code']);
    } else {
      throw Exception(response.body);
    }
  } catch (error) {
    throw Exception(error);
  }
}

Future<dynamic> currentVoucher() async {
  final box = GetStorage();
  final token = box.read('accessToken');

  try {
    final response = await http.get(
      Uri.parse('https://api.alphanetverse.com/api/me/vouchers/current/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.statusCode);
    final res = response.body;
    if (response.statusCode == 200) {
      if (res == {}) {
        return {'is_enabled': false};
      }
      return json.decode(response.body);
    } else {
      return {'is_enabled': false};
    }
  } catch (error) {
    throw Exception(error);
  }
}

//Function that get data from currentVoucher() to check if the voucher enabled or not
Future<String> currentVoucherEnabled() async {
  final isEnabled = await currentVoucher();
  if (isEnabled['is_enabled'] == null) {
    return 'false';
  }
  print(isEnabled['is_enabled']);
  return isEnabled['is_enabled'].toString();
}

Future<List<dynamic>> ownedVoucher() async {
  final box = GetStorage();
  final token = box.read('accessToken');

  try {
    final response = await http.get(
      Uri.parse('https://api.alphanetverse.com/api/me/vouchers/owned/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
      //box.write('voucherCode', json.decode(response.body)['code']);
      //box.write('voucherCode', code['code']);
    } else {
      throw Exception(response.body);
    }
  } catch (error) {
    throw Exception(error);
  }
}

Future<void> sendVoucherToCurrent(String voucherCode) async {
  final box = GetStorage();
  final token = box.read('accessToken');

  try {
    final response = await http.put(
      Uri.parse(
          'https://api.alphanetverse.com/api/vouchers/$voucherCode/to_current/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Handle success if needed
      if (response.body.contains('Current')) {
        await Get.snackbar(
          backgroundColor: Colors.yellow[800],
          duration: Duration(seconds: 1),
          'Error',
          'Current subscription already has a voucher.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        await Get.snackbar(
          duration: Duration(seconds: 1),
          'Success',
          'Voucher sent to current successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      // Handle failure if needed
      print('Failed to send voucher to current: ${response.body}');
      print(response.statusCode);
    }
  } catch (error) {
    // Handle errors
    print('Error sending voucher to current: $error');
  }
}

Future<void> sendVoucherToFriend(String voucherCode, String email) async {
  final box = GetStorage();
  final token = box.read('accessToken');
  Map<String, dynamic> data = {"email": email};
  try {
    final response = await http.put(
        Uri.parse(
            'https://api.alphanetverse.com/api/vouchers/$voucherCode/send_to/'),
        headers: {'Authorization': 'Bearer $token'},
        body: data);
    final res = response.body;
    if (response.statusCode == 200) {
      if (res == {}) {
        print('OK');
      }
      return json.decode(response.body);
    } else {
      print('Faild');
    }
  } catch (error) {
    throw Exception(error);
  }
}
