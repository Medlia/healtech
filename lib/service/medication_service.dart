import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MedicationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const androidChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'Medicine Notifications',
    description: 'This channel is used to send medicine reminders',
    importance: Importance.high,
  );

  static Future initializeNotification() async {
    await FirebaseMessaging.instance.requestPermission();
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

    final channel =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await channel!.createNotificationChannel(androidChannel);
  }

  static Future didReceiveNotificationResponse(
      NotificationResponse response) async {
    GlobalKey<NavigatorState>().currentState!.pushNamedAndRemoveUntil(
          '/navbar',
          (route) => false,
        );
  }

  static displayNotification(
      {required String title, required String body}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: androidChannel.description,
      importance: Importance.max,
      priority: Priority.high,
      channelAction: AndroidNotificationChannelAction.createIfNotExists,
      icon: 'appicon',
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Notification',
    );
  }

  static scheduledNotification(
      int hour, int minutes, String body) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "HealTech",
      body,
      convertTime(hour, minutes),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          importance: Importance.high,
          priority: Priority.max,
          icon: 'appicon',
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
