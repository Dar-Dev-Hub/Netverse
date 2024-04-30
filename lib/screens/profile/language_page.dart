import 'package:alphanetverse/controllers/translation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../voucher/common/color_extension.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final TranslationController _translationController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Get device dimensions
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: TColor.white,
      appBar: AppBar(
        backgroundColor: TColor.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 20,
            height: 20,
            color: TColor.secondaryText,
          ),
        ),
        title: Text(
          "Language",
          style: TextStyle(color: TColor.primaryText, fontSize: 20),
        ),
      ),
      body: Center(
        // button to choose between en or fr
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // English button
            ElevatedButton(
              onPressed: () {
                _translationController.changeLocale('en');
              },
              child: Text(
                "English",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColor.primary,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // French button
            ElevatedButton(
              onPressed: () {
                _translationController.changeLocale('fr');
              },
              child: Text(
                "French",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColor.primary,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            Text(
              'appname'.tr,
              style: GoogleFonts.roboto(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
