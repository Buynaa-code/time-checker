import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// Notifications объект үүсгэх
final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();

// Notifications эхлүүлэх функц
void initializeNotifications() async {
  // Зөвшөөрөл шалгах
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  // Android эхлүүлэлт
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await notifications.initialize(initializationSettings);
}

// Мэдэгдэл харуулах функц
void showNotification(String message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'chat_channel', // Суваг ID
    'Chat Notifications', // Суваг нэр
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await notifications.show(
    0, // Notification ID
    'Шинэ зурвас', // Гарчиг
    message, // Мэдээлэл
    platformChannelSpecifics,
  );
}
