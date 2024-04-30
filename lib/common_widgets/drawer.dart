// ignore_for_file: prefer_const_constructors

//import 'package:alphanetverse/screens/coming_soon.dart';
import 'package:alphanetverse/screens/home/home_screen.dart';
import 'package:alphanetverse/screens/voucher/voucher.dart';
import 'package:alphanetverse/screens/walletscreen/Parentwallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../screens/profile/profile_screen.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'HOME',
            baseStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            selectedStyle: TextStyle(),
          ),
          HomePage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Profile',
            baseStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
              fontSize: 20.0,
            ),
            selectedStyle: TextStyle(),
          ),
          ProfileScreen()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Voucher',
          baseStyle: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
            fontSize: 20.0,
          ),
          selectedStyle: TextStyle(),
        ),
        Voucher_screen(),
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Wallet',
            baseStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
              fontSize: 20.0,
            ),
            selectedStyle: TextStyle(),
          ),
          CreditCardsPage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HiddenDrawerMenu(
        backgroundColorMenu: Color.fromARGB(185, 0, 135, 189),
        screens: _pages,
        initPositionSelected: 0,
        backgroundColorAppBar: Color.fromARGB(186, 0, 135, 189),
        tittleAppBar: Center(
          child: SvgPicture.asset(
            'assets/img/trace.svg',
            width: 70,
            height: 150,
            color: Colors.white,
          ),
        ),
        actionsAppBar: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            color: Colors.black,
            onPressed: () => Get.toNamed('/notification'),
          ),
        ],

        // actionsAppBar: [
        //   Builder(
        //     builder: (context) => IconButton(
        //       icon: Icon(Icons.notifications_outlined),
        //       onPressed: () => Scaffold.of(context).openEndDrawer(),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
