import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/user/edit_profile_api.dart';
import '../../common_widgets/snack_message/snack_message.dart';
import '../../controllers/auth_controller.dart';
import '../voucher/common_widget/round_buttom.dart';
import '../voucher/common_widget/round_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthController authController = Get.find();
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(218, 172, 126, 0),
        title: Center(
          child: Text(
            'Edit Profile',
            style: GoogleFonts.poppins(
              color: const Color(0xff2E2E2E),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color(0xff2E2E2E),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.25,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(218, 172, 126, 0),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Color.fromARGB(218, 172, 126, 0),
                                    ),
                                  ),
                          ),
                          SizedBox(height: height * 0.02),
                          Text(
                            '${authController.user['first_name']}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${authController.user['email']}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: width * 0.25,
                      right: height * 0.17,
                      child: GestureDetector(
                        onTap: () {
                          _getImage();
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 180, 178, 178),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundTextField(
                        title: 'First Name',
                        hitText: '${authController.user['first_name']}',
                        controller: authController.firstNameController,
                      ),
                      const SizedBox(height: 20),
                      RoundTextField(
                        title: 'Last Name',
                        hitText: '${authController.user['last_name']}',
                        controller: authController.lastNameController,
                      ),
                      const SizedBox(height: 20),
                      RoundTextField(
                        title: 'Email',
                        hitText: '${authController.user['email']}',
                        controller: authController.emailController,
                      ),
                      const SizedBox(height: 20),
                      RoundTextField(
                        title: 'Phone Number',
                        hitText: '${authController.user['phone']}',
                        controller: authController.phoneController,
                      ),
                      const SizedBox(height: 30),
                      RoundButton(
                        colors: const Color.fromARGB(218, 172, 126, 0),
                        title: 'Save',
                        onPressed: () async {
                          await updateUserProfile(
                            updatedFirstName:
                                authController.firstNameController.text.trim(),
                            updatedLastName:
                                authController.lastNameController.text.trim(),
                            updatedEmail:
                                authController.emailController.text.trim(),
                            updatedPhone:
                                authController.phoneController.text.trim(),
                          );
                          await authController.fetchUserData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: CustomSnackBarContent(
                                title: 'Success',
                                message: 'Your profile has been updated.',
                                bgcolor: Colors.green,
                                bubcolor: Color.fromARGB(255, 0, 114, 4),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
