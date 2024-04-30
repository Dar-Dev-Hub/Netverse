import 'package:alphanetverse/screens/voucher/common/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/my_textfield.dart';
import '../../controllers/auth_controller.dart';
import '../voucher/common_widget/round_buttom.dart';

import 'package:get_storage/get_storage.dart';

import 'controllers/fetch_subProfile.dart';
import 'controllers/subprofile_api.dart';
import 'sub_profile_list.dart';

class SubProfile extends StatelessWidget {
// Constructor
  final box = GetStorage();
  var code;
  final subprofileNameController = TextEditingController();
  final codeController = TextEditingController();

  SubProfile({super.key});
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    // Get device dimensions
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final AuthController authController = Get.find();
    final SubProfileController subProfileController =
        Get.put<SubProfileController>(SubProfileController());

    // Check if the subscription is active

    return Scaffold(
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
            "Add Sub Profile",
            style: TextStyle(color: TColor.primaryText, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  "assets/img/subprofile.png",
                  width: media.width * 0.5,
                  height: media.height * 0.19,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                  Text(
                    "Add a Sub Profile",
                    style: TextStyle(color: TColor.primaryText, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "a sub profile is a profile that you can created to be able to gain more rewards and you can transfer your points  to your profile.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.secondaryText, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                      colors: const Color.fromARGB(218, 172, 126, 0),
                      title: "Add a Sub Profile",
                      onPressed: () {
                        _showAlertDialog(context);
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              var selectedMainProfile = ''.obs;
                              subProfileController
                                  .fetchSubProfile(selectedMainProfile.value);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubprofileList(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              decoration: BoxDecoration(
                                  color: TColor.white,
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 2))
                                  ]),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/img/sub.png",
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Sub Profile List",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: TColor.secondaryText,
                                          fontSize: 14),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }

  void _showAlertDialog(BuildContext context) async {
    try {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Confirmation',
              style: TextStyle(color: TColor.primaryText, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Are you sure you want to add a Sub Profile?',
              textAlign: TextAlign.center,
              style: TextStyle(color: TColor.secondaryText, fontSize: 17),
            ),
            actions: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.white,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    side: BorderSide(color: Colors.green, width: 0.5),
                  ),
                ),
                label: const Text('YES'),
                icon: const Icon(Icons.check),
                onPressed: () {
                  try {
                    Navigator.pop(context);
                    __showAlertForinputusername(context);
                  } catch (error) {
                    print('Error : $error');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Error. Please try again.'),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  backgroundColor: Colors.white,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                  ),
                  side: const BorderSide(color: Colors.redAccent, width: 0.5),
                ),
                label: const Text('NO'),
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                  print('Pressed');
                },
              ),
              const SizedBox(width: 10),
            ],
          );
        },
      );
    } catch (error) {
      print('Error showing AlertDialog: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Error showing AlertDialog. Please try again.'),
        ),
      );
    }
  }

  void __showAlertForinputusername(BuildContext context) async {
    try {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Add a Sub Profile',
              style: TextStyle(color: TColor.primaryText, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              MyTextField(
                controller: subprofileNameController,
                hintText: 'Enter Sub Profile Name',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(width: 30),
              MyTextField(
                controller: codeController,
                hintText: 'Voucher Code',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(width: 30),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.white,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                        side: BorderSide(color: Colors.green, width: 0.5),
                      ),
                    ),
                    label: const Text('YES'),
                    icon: const Icon(Icons.check),
                    onPressed: () async {
                      try {
                        Navigator.pop(context);

                        await subProfile(
                            subprofileNameController.text, codeController.text);
                      } catch (error) {
                        print('Error : $error');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Error. Please try again.'),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      backgroundColor: Colors.white,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                      side:
                          const BorderSide(color: Colors.redAccent, width: 0.5),
                    ),
                    label: const Text('NO'),
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                      print('Pressed');
                    },
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          );
        },
      );
    } catch (error) {
      print('Error showing AlertDialog: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Error showing AlertDialog. Please try again.'),
        ),
      );
    }
  }
}
