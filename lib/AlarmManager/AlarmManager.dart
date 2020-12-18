// The Alarm manager for the med-Reminder

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:medicine_reminder/PatientScreen/MedicineCard.dart';
import 'TimeZone.dart';

Random random = new Random();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AlarmManager {

  // Add the following override method to your Stateless class before usage
  // @override
  // void initState() {
  //   super.initState();
  //   var initializationSettingsAndroid =
  //   AndroidInitializationSettings('applogo');
  //   var initializationSettingsIOs = IOSInitializationSettings();
  //   var initSettings = InitializationSettings(
  //       android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
  //   flutterLocalNotificationsPlugin.initialize(initSettings,
  //       onSelectNotification: onSelectNotification);
  // }

  int getNotificationId() {
    return random.nextInt(90000) + 10000;
  }

  Future onSelectNotification(String payload, BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return MedicineCard();
    }));
  }

  Future<TimeOfDay> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 00),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Color(0xffbb86fe),
                  onPrimary: Color(0xff121212),
                  surface: Color(0xff121212),
                  onSurface: Color(0xfff2e7fe),
                ),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
                dialogBackgroundColor: Color(0xffbb86fe)),
            child: child,
          );
        });
    return picked;
  }

  Future<int> showNotification(
      int notificationId, String title, String body) async {
    var android = new AndroidNotificationDetails(
      'id',
      'Channel',
      'Description',
      priority: Priority.high,
      importance: Importance.max,
      color: Color(0xFFbb86fe),
      largeIcon: DrawableResourceAndroidBitmap('applogo_large'),
    );
    var iOS = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        notificationId, title, body, platformChannelSpecifics);
    return notificationId;
  }

  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> repeatNotification(
      int notificationId, String title, String body, bool interval) async {
    var android = new AndroidNotificationDetails(
      'id',
      'Channel',
      'Description',
      priority: Priority.high,
      importance: Importance.max,
      color: Color(0xFFbb86fe),
      largeIcon: DrawableResourceAndroidBitmap('applogo_large'),
    );
    RepeatInterval repeatInterval =
        interval ? RepeatInterval.daily : RepeatInterval.weekly;
    var iOS = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        notificationId, title, body, repeatInterval, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  Future<void> scheduleNotification(
      int notificationId, String title, String body, DateTime dateTime) async {
    final timeZone = TimeZone();
    String timeZoneName = await timeZone.getTimeZoneName();
    final location = await timeZone.getLocation(timeZoneName);
    final scheduledNotificationDateTime =
        tz.TZDateTime.from(dateTime, location);
    var android = new AndroidNotificationDetails(
      'id',
      'Channel',
      'Description',
      priority: Priority.high,
      importance: Importance.max,
      ongoing: true,
      autoCancel: false,
      color: Color(0xFFbb86fe),
      largeIcon: DrawableResourceAndroidBitmap('applogo_large'),
    );
    var iOS = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.zonedSchedule(notificationId, title,
        body, scheduledNotificationDateTime, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation: null,
        androidAllowWhileIdle: true);
  }
}
