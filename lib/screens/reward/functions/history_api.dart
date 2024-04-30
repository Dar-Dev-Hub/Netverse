import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoryController extends GetConnect {
  RxInt dailyReward = 20.obs;
  final box = GetStorage();
  Future<void> historyController() async {
    final token = box.read('accessToken');
    try {
      final res = await get(
        ('https://api.alphanetverse.com/api/statistics/me/ads/weekly'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA${res.body}');
      if (res.statusCode == 200) {}
    } catch (e) {
      stderr.writeln(e);
    }
  }
}
