import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class VersionChecker {
  final box = GetStorage();
  final String apiUrl =
      'https://api.alphanetverse.com/api/site-configuration/current-version/';

  Future<bool> isAppUpToDate(String currentVersion, String platform) async {
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> versionData = json.decode(response.body);

        String latestVersion = platform == 'Android'
            ? versionData['Android Version']
            : versionData['iOS Version'];

        return latestVersion == currentVersion;
      }
      return false;
    } catch (e) {
      print('Error checking app version: $e');
      return false;
    }
  }
}
