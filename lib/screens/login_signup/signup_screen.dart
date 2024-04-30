// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_import

import 'package:alphanetverse/api/login_signup/signup_api.dart';
import 'package:alphanetverse/screens/voucher/common_widget/round_buttom.dart';
//import 'package:alphanetverse/services/adhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../components/my_textfield.dart';
import '../../controllers/location_service.dart';

class SignupScreen extends StatelessWidget {
  final box = GetStorage();
  final RxBool isLoading = false.obs;

  // Route name
  static const routeName = '/signup';

  // Text editing controllers
  final TextEditingController codeController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  String selectedGender = '';
  SignupScreen({super.key});

  void signUp() async {
    isLoading(true);
    if (codeController.text.isEmpty ||
        firstnameController.text.isEmpty ||
        lastnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        passwordConfirmationController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      isLoading(false);
      return;
    }
    if (passwordController.text != passwordConfirmationController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      isLoading(false);
      return;
    }

    await SignupApi.signUp(
      code: codeController.text,
      email: emailController.text.toLowerCase(),
      firstName: firstnameController.text,
      lastName: lastnameController.text,
      phone: phoneController.text,
      password: passwordController.text,
      gender: selectedGender,
      context: Get.context!,
    );
    isLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    final codeCountry = box.read('CounrtyCode');
    codeCountry ?? 'TN';
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          // Dismiss the keyboard when tapping outside of text fields
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20),
                      child:
                          // SvgPicture.network(
                          //   'https://alphanetverse.com/wp-content/uploads/2022/07/alphanetverse-LOGO.svg',
                          //   color: Colors.red,
                          //   width: 200,
                          //   height: 120,
                          //   alignment: Alignment.topCenter,
                          // ),
                          SvgPicture.asset(
                        'assets/img/trace.svg',
                        width: 200,
                        height: 180,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                        'Sign up today and join our amazing community!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: codeController,
                      hintText: 'Code',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      suffixIcons: IconButton(
                        icon: const Icon(Icons.qr_code_scanner_rounded),
                        onPressed: () async {
                          var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SimpleBarcodeScannerPage(),
                            ),
                          );
                          if (res != null && res.toString() != '-1') {
                            codeController.text = res.toString();
                          } else {
                            print('No result');
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'If you dont have a Code click here to contact our  ',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 10),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/Sos'); // Navigate to the login page
                          },
                          child: const Text(
                            'Support.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: IntlPhoneField(
                        initialCountryCode: codeCountry.toString(),
                        controller: phoneController,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 68, 67, 67)),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: 'Phone number',
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        languageCode: "en",
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: firstnameController,
                      hintText: 'First Name',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: lastnameController,
                      hintText: 'Last Name',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),

                    // MyTextField(
                    //   controller: phoneController,
                    //   hintText: 'Phone number',
                    //   obscureText: false,
                    //   keyboardType: TextInputType.emailAddress,
                    // ),

                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: passwordConfirmationController,
                      hintText: 'Password Confirmation',
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 68, 67, 67)),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Gender',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                        value:
                            selectedGender.isNotEmpty ? selectedGender : null,
                        onChanged: (newValue) {
                          if (newValue == 'M') {
                            selectedGender = 'M';
                          } else {
                            selectedGender = 'F';
                          }
                        },
                        items: <String>['M', 'F']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value == 'M' ? 'Male' : 'Female',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Obx(() {
                        return isLoading.isTrue
                            ? CircularProgressIndicator() // Show loading indicator
                            : Column(
                                children: [
                                  RoundButton(
                                      colors: const Color.fromARGB(
                                          218, 172, 126, 0),
                                      title: "Sign Up",
                                      onPressed: () => signUp()),
                                ],
                              );
                      }),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already a member? ',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/login'); // Navigate to the login page
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
