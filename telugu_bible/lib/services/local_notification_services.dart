import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  //for android configuration
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  void initializeNotifications() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);

    await _flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "default_notification_channel_id",
      "telugu_bible",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      category: AndroidNotificationCategory.progress,
      // audioAttributesUsage: AudioAttributesUsage.alarm,
      timeoutAfter: 2600,
      sound: RawResourceAndroidNotificationSound("noti"),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  //for schedule notification
  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledDateTime, int id) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "default_notification_channel_id",
      "telugu_bible",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      category: AndroidNotificationCategory.progress,
      // audioAttributesUsage: AudioAttributesUsage.,
      timeoutAfter: 2600,
      sound: RawResourceAndroidNotificationSound("noti"),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDateTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
