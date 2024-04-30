// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:alphanetverse/comming_soon/commingsoon.dart';
import 'package:alphanetverse/controllers/auth_controller.dart';
import 'package:alphanetverse/screens/Actualite/act.dart';
import 'package:alphanetverse/theme/app_styles.dart';
import 'package:alphanetverse/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

import '../Events/events.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void onItemTapped(int index, RxInt selectedIndex) {
    selectedIndex.value = index; // Update the selected index reactively
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final AuthController authController = Get.find();
    String formattedDate = DateFormat('EEEE, d MMMM').format(DateTime.now());
    final RxInt selectedIndex = 0.obs; // Use RxInt for reactive index

    final List<Widget> widgetOptions = <Widget>[
      Act(),
      Events(), // Placeholder for Button 1 content

      Commingsoon(),
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 51,
                        width: 51,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          color: kLightBlue,
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://cdn3d.iconscout.com/3d/premium/thumb/man-avatar-6299539-5187871.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome,' +
                                ' ${authController.user['first_name']} !',
                            style: kPoppinsBold.copyWith(
                              fontSize: SizeConfig.blockSizeHorizontal! * 4,
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: kPoppinsRegular.copyWith(
                              color: kGrey,
                              fontSize: SizeConfig.blockSizeHorizontal! * 3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/turn-off.svg',
                      width: 50,
                      height: 50,
                      color: const Color.fromARGB(218, 172, 126, 0),
                    ),
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Logout',
                        titleStyle: TextStyle(fontSize: 20),
                        content: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text('Are you sure !'),
                        ),
                        confirm: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                final AuthController authController =
                                    Get.find();
                                authController.logoutUser();
                              },
                              child: Text('Yes'),
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'No',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              //end of row logout
            ),
            Container(
              height: SizeConfig.blockSizeHorizontal! * 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Center(
                child: Row(
                  children: [
                    buildNavItem(
                      0,
                      'Actualité',
                      Icons.home,
                      selectedIndex,
                    ),
                    buildNavItem(
                      1,
                      'Events',
                      Icons.event,
                      selectedIndex,
                    ),
                    buildNavItem(
                      2,
                      'Soon',
                      Icons.hourglass_bottom_outlined,
                      selectedIndex,
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => Expanded(
                  child: widgetOptions.elementAt(selectedIndex.value),
                  flex: 1,
                )),
          ],
        ),
        //obx
      ),
    );
  }

  Widget buildNavItem(
      int index, String title, IconData iconData, RxInt selectedIndex) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          onItemTapped(index, selectedIndex);
        },
        child: Column(
          children: [
            Icon(
              iconData,
              color: const Color.fromARGB(218, 172, 126, 0),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                title,
                style: TextStyle(
                  // Customize text style based on your needs
                  color: const Color.fromARGB(218, 172, 126, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
