import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

// for background popup notification, just configure android manifest and add the channel id

// for foreground popup notification, we need to configure a method
// for firebase onMessage method because firebase doesn't show the
// pop up notification when the app is open so we need to explicity
// tell android to force show it

class LocalNotificationService {
  // Provides cross-platform functionality for displaying local notifications.
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  // initialize local notification settings
  // if you need to route the user somewhere, you need to add a context and navigator
  static void initialize(BuildContext context) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(),
    );

    _notificationPlugin.initialize(
      initializationSettings,
      //* this part is optional start
      //* you can use this if you want to route the user to a specific page
      //* when the notification is received in the foreground (when app is open)
      //* make sure to add context as parameter if you are going to use this
      onSelectNotification: (String? route) async {
        if (route != null) {
          Navigator.pushNamed(context, '/$route');
        }
      },
      //* this part is optional end
    );
  }

  // create the notification channel
  // displayNotification is only used when the notif is received
  // in the foreground (when the app is open)
  // this part is only used for firebase onMessage method
  static void displayNotification(RemoteMessage message) async {
    try {
      // id needs to be unique everytime so we use milliseconds as id generator
      // id is unique so that every notification will have its own notification tray
      // if id is the same, then all notifications will just use a single notificaton tray
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // configure channel settings here
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'user_defined_channel_id',
          'user defined channel name',
          'user defined channel description',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: IOSNotificationDetails(),
      );

      // show pop up notification
      await _notificationPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        //* this part is optional start
        //* payload is the custom data to be sent along with the notification
        payload: message.data['route'],
        //* this part is optional end
      );
    } catch (e) {
      // print(e);
    }
  }
}
