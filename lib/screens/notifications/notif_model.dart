class NotificationModel {
  String id; 
  String title;
  String message;
  bool isSeen;
  DateTime timestamp;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    this.isSeen = false,
    required this.timestamp,
  });
}
