import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alphanetverse/screens/notifications/notif_model.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  Future<void> fetchNotifications() async {
    final box = GetStorage();
    final token = box.read('accessToken');
    final url = 'https://api.alphanetverse.com/api/me/notifications';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        notifications.assignAll(data
            .map((e) => NotificationModel(
                  id: e['id'],
                  title: e['title'],
                  message: e['message'],
                  isSeen: e['is_read'],
                  timestamp:
                      DateTime.parse(e['sent_at'] ?? DateTime.now().toString()),
                ))
            .toList());
        print('Notifications fetched successfully');
      } else {
        throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  Future<void> markAllAsRead() async {
    final box = GetStorage();
    final token = box.read('accessToken');
    final url =
        'https://api.alphanetverse.com/api/me/notifications/mark_all_as_read';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to mark all notifications as read');
      }

      // Assuming you want to clear notifications locally after marking all as read
      notifications.clear();

      print('All notifications marked as read');
    } catch (e) {
      print('Error marking all notifications as read: $e');
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    final box = GetStorage();
    final token = box.read('accessToken');
    final url =
        'https://api.alphanetverse.com/api/me/notifications/$notificationId/mark_as_read';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final index =
            notifications.indexWhere((notif) => notif.id == notificationId);
        if (index != -1) {
          notifications[index].isSeen = true;
          notifications.refresh();
        }
        print('Notification marked as read');
      } else {
        throw Exception('Failed to mark notification as read');
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }
}
