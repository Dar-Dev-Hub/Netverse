// import 'package:alphanetverse/screens/coming_soon.dart';
// import 'package:alphanetverse/screens/home/home.dart';
// import 'package:alphanetverse/screens/profile/profile_screen.dart';
// import 'package:alphanetverse/screens/reward/reward.dart';
// import 'package:alphanetverse/screens/voucher/common/color_extension.dart';
// import 'package:alphanetverse/screens/voucher/voucher.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';

// class MainTabView extends StatefulWidget {
//   const MainTabView({super.key});

//   @override
//   State<MainTabView> createState() => _MainTabViewState();
// }

// class _MainTabViewState extends State<MainTabView>
//     with SingleTickerProviderStateMixin {
//   TabController? controller;
//   int selectTab = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

//     controller = TabController(length: 5, vsync: this);
//     controller?.addListener(() {
//       selectTab = controller?.index ?? 0;
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: TColor.white,
//         body: TabBarView(
//           controller: controller,
//           children: const [
//             Home(),
//             Reward_page(),
//             Voucher_screen(),
//             ProfileScreen(),
//             comingSoon(),
//           ],
//         ),
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(color: TColor.white, boxShadow: const [
//             BoxShadow(
//                 color: Colors.black12, blurRadius: 3, offset: Offset(0, -2))
//           ]),
//           child: BottomAppBar(
//               color: Colors.transparent,
//               elevation: 0,
//               child: TabBar(
//                 controller: controller,
//                 indicator: BoxDecoration(
//                     border: Border(
//                         top: BorderSide(color: TColor.primary, width: 3.0))),
//                 indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
//                 tabs: [
//                   Tab(
//                     icon: SvgPicture.asset(
//                       selectTab == 0
//                           ? "assets/Icons/Home_icon.svg"
//                           : "assets/Icons/badge_reward.svg",
//                       width: 30,
//                       height: 30,
//                     ),
//                   ),
//                   Tab(
//                     icon: SvgPicture.asset(
//                       selectTab == 1
//                           ? "assets/Icons/Home_icon.svg"
//                           : "assets/Icons/badge_reward.svg",
//                       width: 30,
//                       height: 30,
//                     ),
//                   ),
//                   Tab(
//                     icon: SvgPicture.asset(
//                       selectTab == 2
//                           ? "assets/Icons/Home_icon.svg"
//                           : "assets/Icons/badge_reward.svg",
//                       width: 30,
//                       height: 30,
//                     ),
//                   ),
//                   Tab(
//                     icon: SvgPicture.asset(
//                       selectTab == 3
//                           ? "assets/Icons/Home_icon.svg"
//                           : "assets/Icons/badge_reward.svg",
//                       width: 30,
//                       height: 30,
//                     ),
//                   ),
//                   Tab(
//                     icon: SvgPicture.asset(
//                       selectTab == 4
//                           ? "assets/Icons/Home_icon.svg"
//                           : "assets/Icons/badge_reward.svg",
//                       width: 30,
//                       height: 30,
//                     ),
//                   )
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
