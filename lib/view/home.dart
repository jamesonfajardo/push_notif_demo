import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vzugruonvv/services/local_notification_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    // if you need to initialize with context
    LocalNotificationService.initialize(
        context); // from local_notification_service.dart

    // onMessage method works properly when getInitialMessage() is configured
    // getInitialMessage - this notification will only work if the app is closed (terminated)
    // upon clicking the notification in the notification tray - it will open the app
    // upon clicking the notification in the notification tray - it will run the callback
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // route is a user defined key
        Navigator.pushNamed(context, '/${message.data['route']}');
      }
    });

    // this notification will only work if the app is open (foreground)
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print('Title: ${message.notification!.title}');
        print('Body: ${message.notification!.body}');
        print('Android: ${message.notification!.android!.imageUrl}');
        // print('Apple: ${message.notification!.apple!.imageUrl}'); // for ios

        LocalNotificationService.displayNotification(
            message); // from local_notification_service.dart
      }
    });

    // this notification will only work if the app is minimized (background process)
    // this callback will get triggered when the notification is clicked
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.isNotEmpty) {
        // route is a user defined key
        print(message.data['route']);

        // message.data['userDefinedKey'] - could be a route or anything actually
        // route is a user defined key
        Navigator.pushNamed(context, '/${message.data['route']}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(),
          Text('Try sending a notification through firebase'),
        ],
      ),
    );
  }
}
