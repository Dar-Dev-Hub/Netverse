import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alphanetverse/screens/notifications/notif_model.dart';
import 'package:alphanetverse/screens/notifications/notif_controller.dart';
import 'package:alphanetverse/screens/voucher/common/color_extension.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    notificationController.fetchNotifications();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 20,
            height: 20,
            color: TColor.secondaryText,
          ),
        ),
        title: Text(
          "Notifications",
          style: TextStyle(color: TColor.primaryText, fontSize: 20),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notificationController.notifications.length,
                itemBuilder: (context, index) {
                  final notification =
                      notificationController.notifications[index];

                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor:
                            notification.isSeen ? Colors.grey : Colors.blue,
                        radius: 24,
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        notification.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        notification.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!notification.isSeen)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'New',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        notificationController
                            .markNotificationAsRead(notification.id);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notificationController.markAllAsRead();
        },
        child: Icon(Icons.done, color: Colors.white),
        backgroundColor: Color.fromARGB(218, 172, 126, 0),
      ),
    );
  }
}
