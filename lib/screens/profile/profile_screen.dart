import 'package:alphanetverse/screens/voucher/common/color_extension.dart';
import 'package:alphanetverse/screens/voucher/controllers/qr_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sensitive_clipboard/sensitive_clipboard.dart';

import '../../controllers/auth_controller.dart';
import '../../theme/app_styles.dart';
import '../voucher/common_widget/round_buttom.dart';
import 'update_profile.dart';

final AuthController authController = Get.find();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String isActiveb = authController.user['subscription_status'] ?? "";
  String tProfile = 'Profile';
  String tProfileImage =
      'https://cdn3d.iconscout.com/3d/premium/thumb/man-avatar-6299539-5187871.png';
  String tProfileHeading = 'John Doe';
  String tProfileSubHeading = 'johndoe@example.com';
  Color tPrimaryColor = Colors.blue;
  Color tDefaultColor = Colors.grey;
  double tDefaultSize = 20.0;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    final userData = authController.user;

    print(userData);
    String firstName = userData['first_name'] ?? "";
    String lastName = userData['last_name'] ?? "";
    String referralCode = userData['referral_code'] ?? "";
    tProfileSubHeading = userData['email'] ?? "";
    void showAlertDialog(BuildContext context) async {
      try {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(referralCode),
                content: SizedBox(
                  width: 70,
                  child: QRCodeWidget(data: referralCode),
                ),
                actions: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Click To copy code",
                                style: TextStyle(
                                    color: TColor.secondaryText, fontSize: 12)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: IconButton(
                                onPressed: () {
                                  SensitiveClipboard.copy(referralCode);
                                  final snackBar = SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Copied: $referralCode'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ],
              );
            });
      } catch (e) {
        SnackBar snackBar = const SnackBar(
            duration: Duration(seconds: 1), content: Text("Not Active"));
      }
    }

    print(userData);
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          // Profile Image
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 100,
          //     width: 100,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       image: DecorationImage(
          //         image: AssetImage(tProfileImage),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          // Profile Name and Email
          ListTile(
            leading: Container(
              width: 71,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadius),
                color: kLightBlue,
                image: DecorationImage(
                  image: NetworkImage(
                    tProfileImage,
                  ),
                ),
              ),
            ),
            title: Text(
              "${firstName.capitalize} ${lastName.capitalize}",
              style: GoogleFonts.rubik(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              tProfileSubHeading,
              style: GoogleFonts.rubik(
                  color: Colors.black, fontWeight: FontWeight.w400),
            ),
            trailing: isActiveb.toLowerCase() == 'true'
                ? Column(
                    children: [
                      Text(
                        referralCode,
                        style: GoogleFonts.rubik(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () => showAlertDialog(context),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: QRCodeWidget(data: referralCode),
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
          ),
          // Edit Button

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: TColor.white,
                borderRadius: BorderRadius.circular(3),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            child: Column(children: [
              RoundButton(
                  colors: const Color.fromARGB(218, 172, 126, 0),
                  title: "Edit Profile",
                  onPressed: () {
                    Get.to(() => const EditProfileScreen());
                  }),
            ]),
          ),
          // List Items
          Center(
            heightFactor: 1.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  focusColor: Colors.red,
                  onTap: () => {
                    print('Document Verification'),
                    Get.toNamed('/document_verification')
                  },
                  leading:
                      Icon(LineAwesomeIcons.file_contract, size: tDefaultSize),
                  title: const Text('Document Verification'),
                  trailing:
                      Icon(LineAwesomeIcons.angle_right, size: tDefaultSize),
                ),
                ListTile(
                  leading: Icon(LineAwesomeIcons.codie_pie, size: tDefaultSize),
                  title: const Text('Current Subscription'),
                  trailing:
                      Icon(LineAwesomeIcons.angle_right, size: tDefaultSize),
                  onTap: () {
                    Get.toNamed('/current_subscription');
                  },
                ),
                ListTile(
                  leading: Icon(LineAwesomeIcons.medal, size: tDefaultSize),
                  title: const Text('My Owned Vouchers'),
                  trailing:
                      Icon(LineAwesomeIcons.angle_right, size: tDefaultSize),
                  onTap: () {
                    Get.toNamed('/Myvoucher');
                  },
                ),
                ListTile(
                  leading: Icon(LineAwesomeIcons.history, size: tDefaultSize),
                  title: const Text('Transaction History'),
                  trailing:
                      Icon(LineAwesomeIcons.angle_right, size: tDefaultSize),
                ),
                ListTile(
                  leading:
                      Icon(LineAwesomeIcons.user_circle, size: tDefaultSize),
                  title: const Text('Add Sub Profile'),
                  trailing:
                      Icon(LineAwesomeIcons.angle_right, size: tDefaultSize),
                  onTap: () {
                    Get.toNamed('/Subprofile');
                  },
                ),
                ListTile(
                  leading: Icon(LineAwesomeIcons.cog, size: tDefaultSize),
                  title: const Text('Settings'),
                  trailing:
                      Icon(LineAwesomeIcons.angle_right, size: tDefaultSize),
                  onTap: () {
                    // Get.toNamed('/Language');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          textColor: Colors.red,
          leading: Icon(
            LineAwesomeIcons.power_off,
            size: tDefaultSize,
            color: Colors.red,
          ),
          title: const Text('Delete Account'),
          onTap: () {
            Get.defaultDialog(
              title: 'Delete Account',
              titleStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              content: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Are you sure you want to delete your account !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              confirm: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Temporarily Deactivate',
                        titleStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        content: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'You account has been temporarily deactivated ! Please contact support to reactivate your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        confirm: ElevatedButton(
                          onPressed: () {
                            final AuthController authController = Get.find();
                            authController.deleteUser();
                          },
                          child: const Text('Desactivate',
                              style: TextStyle(color: Colors.red)),
                        ),
                      );
                    },
                    child: const Text('Yes'),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('No'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
