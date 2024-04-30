import 'package:alphanetverse/components/my_textfield.dart';
import 'package:alphanetverse/screens/voucher/common_widget/round_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../api/login_signup/forget_api.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  // route name
  static const routeName = '/forget';
  // text editing controllers
  final emailController = TextEditingController();

  // sign user in method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20),
                      child: SvgPicture.asset(
                        'assets/img/trace.svg',
                        width: 200,
                        height: 180,
                      ),
                      // SvgPicture.network(
                      //   'https://alphanetverse.com/wp-content/uploads/2022/07/alphanetverse-LOGO.svg',
                      //   color: Colors.red,
                      //   width: 200,
                      //   height: 120,
                      //   alignment: Alignment.topCenter,
                      // ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // logo

                        // welcome back, you've been missed!
                        Text(
                          "It's fine just put your email!",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
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

                        const SizedBox(height: 10),

                        // forgot password?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/login');
                                },
                                child: Text(
                                  'You remember ?',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
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
                              title: "Recover",
                              onPressed: () async {
                                ForgetApi.forget(emailController.text);
                              },
                            ),
                          ]),
                        ),

                        const SizedBox(height: 50),

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
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/signup');
                              },
                              child: const FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Register now With a referral code',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
