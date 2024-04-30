import 'package:alphanetverse/screens/Events/events.dart';
import 'package:alphanetverse/screens/home/homepage.dart';
import 'package:alphanetverse/theme/app_styles.dart';
import 'package:alphanetverse/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/auth_controller.dart';
import '../Actualite/act.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kLighterWhite,
        body: HomePage(),
      ),
    );
  }
}
