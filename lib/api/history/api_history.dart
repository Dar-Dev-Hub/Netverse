import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HistoryApi extends GetxController {
  var data = [].obs;
  Future<void> historyApi() async {
    final box = GetStorage();
    final token = box.read('accessToken');

    try {
      final response = await http.get(
        Uri.parse('https://api.alphanetverse.com/api/statistics/me/ads/weekly'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> dataJ = json.decode(response.body);
        box.write('historyData', dataJ);
        print(dataJ);
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
