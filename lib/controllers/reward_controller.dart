import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RewardController extends GetConnect {
  RxInt dailyReward = 20.obs;
  final box = GetStorage();
  RxString rewardAmount = '0'.obs;

  Future<void> updateRewardAmount() async {
    final selectedSubProfileName = await box.read('selectedSubProfileName');
    final rewards = await selectedSubProfileName == 'Main Profile'
        ? box.read('rewards')
        : box.read('rewardsSub');
    rewardAmount.value = rewards?.toString() ?? '0';
    print(rewardAmount.value);
  }

  Future<void> rewardsMainController() async {
    final token = box.read('accessToken');
    try {
      final res = await get(
        ('https://api.alphanetverse.com/api/my-sub-accounts/left_main/'),
        headers: {'Authorization': 'Bearer $token'},
      );
      final a = res.body.values.toList();
      if (res.statusCode == 200) {
        box.write('rewards', a[0] ?? '0');
      }
    } catch (e) {
      stderr.writeln(e);
    }
  }

  Future<void> rewardsSubController(name) async {
    final token = box.read('accessToken');
    try {
      final res = await get(
        ('https://api.alphanetverse.com/api/my-sub-accounts/$name/left_points/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final a = res.body.values.toList();

      if (res.statusCode == 200) {
        box.write('rewardsSub', a[0] ?? '0');
      }
    } catch (e) {
      stderr.writeln(e);
    }
  }
}
