import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../voucher/common/color_extension.dart';

class CurrentSubscriptionScreen extends StatelessWidget {
  const CurrentSubscriptionScreen({super.key});

// Constructor

  @override
  Widget build(BuildContext context) {
    // Get device dimensions
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final AuthController authController = Get.find();

    // Check if the subscription is active
    String isActiveb = authController.user['subscription_status'] ?? 'active';
    bool isActive = isActiveb.toLowerCase() == 'true' ? true : false;

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
          "Current Subscription",
          style: TextStyle(color: TColor.primaryText, fontSize: 20),
        ),
      ),
      body: Center(
        child: Container(
          width: width * 0.9,
          height: height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white, // Set the container color to white
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Current Subscription : ',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isActive ? 'Active' : 'Inactive',
                    style: GoogleFonts.poppins(
                      color: isActive ? Colors.green : Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isActive ? Colors.green : Colors.red,
                    ),
                    child: Center(
                      child: Icon(
                        isActive ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
              if (isActive)
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Expires on : ${authController.user['subscription_status']}',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
