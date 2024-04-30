import 'dart:io';

import 'package:alphanetverse/common_widgets/drawer.dart';
import 'package:alphanetverse/constants/language/en_strings.dart';
import 'package:alphanetverse/constants/language/fr_strings.dart';
import 'package:alphanetverse/controllers/translation_controller.dart';
import 'package:alphanetverse/screens/home/home_screen.dart';
import 'package:alphanetverse/screens/login_signup/login_screen.dart';
import 'package:alphanetverse/screens/login_signup/signup_screen.dart';
import 'package:alphanetverse/screens/login_signup/sos/sos.dart';
import 'package:alphanetverse/screens/notifications/notification_screen.dart';
import 'package:alphanetverse/screens/profile/current_subscription.dart';
import 'package:alphanetverse/screens/profile/language_page.dart';
import 'package:alphanetverse/screens/profile/profile_screen.dart';

import 'package:alphanetverse/services/firebase/firebase_config.dart';
import 'package:alphanetverse/services/version/current_version.dart';
import 'package:alphanetverse/services/version/update_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'controllers/auth_controller.dart';
import 'screens/login_signup/forget_password.dart';
import 'screens/login_signup/sginup_with_code.dart';
import 'screens/profile/add_sub_profile.dart';
import 'screens/profile/document_verification/document_verification.dart';
import 'screens/profile/my_voucher.dart';
import 'screens/voucher/voucher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthController());
  final AuthController authController = Get.find();
  await authController.fetchUserData();

  VersionChecker versionChecker = VersionChecker();
  String currentVersion = '1.0.1';
  String platform = Platform.operatingSystem;

  bool isUpToDate =
      await versionChecker.isAppUpToDate(currentVersion, platform);

  if (!isUpToDate) {
    runApp(const GetMaterialApp(
      title: 'NetVerse',
      debugShowCheckedModeBanner: false,
      home: UpdateAppScreen(),
    ));
    return;
  }

  // await FirebaseApi().initNotification();
  final device = Platform.operatingSystem;
  print(device);

  // await UnityAds.isInitialized();
  // await UnityAds.init(
  //   // testMode: true,
  //   gameId: device == 'android' ? '5523155' : '5523154',
  //   onComplete: () => print('Initialization Complete'),
  //   onFailed: (error, message) =>
  //       print('Initialization Failed: $error $message'),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final AuthController authController = Get.find();
    // final TranslationController _translationController =
    //     Get.put(TranslationController());

    authController.checkTokenValidityAndRefresh();

    final initialRoute =
        authController.isLoggedIn.isTrue ? '/drawer' : '/login';

    return GetMaterialApp(
      title: 'NetVerse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/drawer', page: () => const HiddenDrawer()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/Sos', page: () => const Sos()),
        GetPage(name: '/forget', page: () => ForgetPassword()),
        GetPage(name: '/signupcode', page: () => SignUpCode()),
        GetPage(name: '/addvoucher', page: () => const Voucher_screen()),
        GetPage(name: '/notification', page: () => NotificationScreen()),
        GetPage(
            name: '/current_subscription',
            page: () => const CurrentSubscriptionScreen()),
        GetPage(
            name: '/document_verification',
            page: () => const DocumentVerifScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/Subprofile', page: () => SubProfile()),
        GetPage(name: '/Myvoucher', page: () => MyVoucher()),
        GetPage(name: '/notification', page: () => NotificationScreen()),
        // GetPage(name: '/Language', page: () => LanguagePage()),
      ],
      // translationsKeys: {
      //   'en': textStringsEn,
      //   'fr': textStringsFr,
      // },
      // locale: Locale(_translationController.selectedLocale),
      // fallbackLocale: Locale('en'),
    );
  }
}
