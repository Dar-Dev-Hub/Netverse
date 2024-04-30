import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

class SubProfileController extends GetxController {
  Future<List<dynamic>> currentSubProfile(String mainProfile) async {
    final box = GetStorage();
    final token = box.read('accessToken');

    try {
      final response = await http.get(
        Uri.parse('https://api.alphanetverse.com/api/my-sub-accounts/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  var subProfileList = [].obs;
  var isLoading = true.obs;
  var selectedMainProfile = ''.obs;

  RxString selectedSubProfileIndex = RxString('');
  void updateSelectedIndex(String newIndex) {
    selectedSubProfileIndex.value = newIndex;
  }

  @override
  void onInit() {
    super.onInit();

    fetchSubProfile(selectedMainProfile.value);

    // Timer.periodic(Duration(seconds: 10), (Timer t) {
    //   fetchFeeds();
    // });
  }

  // Function to fetch feeds using FeedService
  void fetchSubProfile(String mainProfile) async {
    isLoading(true);
    try {
      var response = await currentSubProfile(mainProfile);

      subProfileList.assignAll(response);

      var subProfileNameList = [];

      // Add a default value to the list
      subProfileNameList.add('Main Profile');

      for (var i = 0; i < response.length; i++) {
        subProfileNameList.add(response[i]['name']);
      }

      if (subProfileNameList.length >= 0) {
        selectedSubProfileIndex.value = subProfileNameList[0];
      }

      final box = GetStorage();
      box.write('subProfileNameList', subProfileNameList);

      print("Number of sub profiles: ${subProfileList.length}");
      print("From list: $subProfileNameList");
      print("From GetX storage: ${box.read('subProfileNameList')}");
    } catch (e) {
      print('No data found');
    } finally {
      isLoading(false);
    }
  }
}
