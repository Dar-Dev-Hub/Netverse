import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UserData extends GetxController {
  final box = GetStorage();
  var accessToken = ''.obs;

  String userData() {
    accessToken.value = box.read('accessToken');
    return accessToken.value;
  }

  Future gettingUserData() async {
    final url = Uri.parse('https://api.alphanetverse.com/api/me/');
    final token = userData();
    try {
      final response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});
      print(response.body);
      box.write('userData', jsonDecode(response.body));
    } catch (error) {
      print('Error during login: $error');
    }
  }
}
