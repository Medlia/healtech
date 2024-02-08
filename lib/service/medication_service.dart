import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:get/get.dart';

class MedicationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initializeNotification() async {
    localTimeZone();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: didReceiveNotificationResponse,
    );
  }

  static Future didReceiveNotificationResponse(NotificationResponse response) async {
    Get.to(
      () => Container(),
    );
  }

  static displayNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'Channel ID',
      'Channel Name',
      importance: Importance.max,
      priority: Priority.high,
      channelAction: AndroidNotificationChannelAction.createIfNotExists,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  static scheduledNotification(
      int hour, int minutes, Map<String, dynamic> medicineData) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Scheduled title",
      "This a scheduled demo notification",
      convertTime(hour, minutes),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Channel ID',
          "Channel Name",
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime schedule = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (schedule.isBefore(now)) {
      schedule = schedule.add(const Duration(days: 1));
    }
    return schedule;
  }

  static Future<void> localTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = tz.getLocation(tz.local.name).toString();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}
