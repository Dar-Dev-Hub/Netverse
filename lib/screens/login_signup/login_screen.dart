import 'package:alphanetverse/api/login_signup/login_api.dart';
import 'package:alphanetverse/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/location_service.dart';
import '../voucher/common_widget/round_buttom.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.find(); // Get the auth controller
  LoginPage({super.key});

  // route name
  static const routeName = '/login';
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(LocationService()); // put the auth controller in the tree
    LocationService.getUserCountry();
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
                  children: [
                    // logo
                    //
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 10,
                      ),
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

                    // welcome back, you've been missed!
                    Container(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Text(
                        'Welcome !',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // username textfield
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 10),

                    // password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    // forgot password?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/forget');
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'If you need help, please contact our ',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
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

                    const SizedBox(height: 25),

                    // sign in button

                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Column(children: [
                        RoundButton(
                          colors: const Color.fromARGB(218, 172, 126, 0),
                          title: "Sign In",
                          onPressed: () async {
                            LoginApi.login(emailController.text.toLowerCase(),
                                passwordController.text);
                          },
                        ),
                      ]),
                    ),

                    // or continue with
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Divider(
                    //           thickness: 0.5,
                    //           color: Colors.grey[400],
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //         child: Text(
                    //           'Or continue with',
                    //           style: TextStyle(color: Colors.grey[700]),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Divider(
                    //           thickness: 0.5,
                    //           color: Colors.grey[400],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: 10),

                    // not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign up With a referral code",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/signup');
                          },
                          child: const Text(
                            'Create an account',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Don't have an account?",
                    //       style: TextStyle(color: Colors.grey[700]),
                    //     ),
                    //     const SizedBox(width: 4),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Get.toNamed('/signup');
                    //       },
                    //       child: const Text(
                    //         'Register now',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
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
