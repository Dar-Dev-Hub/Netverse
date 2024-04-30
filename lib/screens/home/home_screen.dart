import 'package:alphanetverse/screens/reward/reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Home(),
    Reward_page(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/Icons/Home_icon.svg",
              width: 35,
              height: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/Icons/badge_reward.svg",
              width: 30,
              height: 30,
            ),
            label: 'Daily Reward',
          ),
        ],
      ),
      body: tabItems[_selectedIndex],
    );
  }
}
