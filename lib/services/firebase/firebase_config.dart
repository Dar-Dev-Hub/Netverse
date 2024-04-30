import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseApi {
  bool isUserLoggedIn = false;
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    showBadge: true,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // go to notification screen with argument message
    Get.toNamed('/notification', arguments: message);
  }

  Future initLocalNotifications() async {
    if (Platform.isIOS) return;

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/ic_launcher'),
      ),
    );
  }

  Future initPushNotifications() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      FirebaseMessaging.onMessage.listen((message) {
        final notification = message.notification;
        if (notification == null) return;

        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      });
    }
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    print('FCMToken2: $FCMToken');
    await initPushNotifications();
    await initLocalNotifications();
  }
}
