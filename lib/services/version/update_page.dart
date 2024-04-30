import 'package:alphanetverse/screens/voucher/common_widget/round_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateAppScreen extends StatelessWidget {
  const UpdateAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Center(
              child: const Text(
                'Update Required',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'A new version of the app is available. Please update the app to continue using it.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(children: [
                RoundButton(
                  colors: const Color.fromARGB(237, 2, 161, 201),
                  title: "Update Now",
                  onPressed: () async {
                    await _update();
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _update() async {
    final String apiUrl =
        'https://api.alphanetverse.com/api/site-configuration/current-version/';
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> versionData = json.decode(response.body);
      print(versionData['APK URL']);
      await launch(versionData['APK URL']);
      return versionData['APK URL'];
    }
  }
}
