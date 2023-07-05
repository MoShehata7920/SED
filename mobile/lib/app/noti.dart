// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:sed/app/di.dart';

import '../presentation/main_screen/main_screen_viewmodel/main_screen_viewmodel.dart';

class Noti {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          final MainScreenViewModel viewModel = instance<MainScreenViewModel>();

          viewModel.selectNotificationStreamController.add('1234');
          break;
        case NotificationResponseType.selectedNotificationAction:
          break;
      }
    });
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String description,
      String summary = "",
      String? imageUrl,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidBitmap<Object>? icon;

    if (imageUrl != null) {
      // Download the image and create an AndroidBitmap object
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final largeIcon = ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(response.bodyBytes));
        icon = largeIcon;
      }
    }

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'you_can_name_it_whatever',
      'flutterfcm',
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('sed'),
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(
        description,
        contentTitle: title,
        summaryText: summary,
        htmlFormatContent: true,
        htmlFormatTitle: true,
      ),
      largeIcon: imageUrl != null
          ? icon
          : const DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
      color: const Color.fromARGB(255, 255, 0, 0),
      colorized: true,
    );

    var not = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails());

    await fln.show(0, title, description, not);
  }
}
