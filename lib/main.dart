import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vzugruonvv/view/bluegrey.dart';
import 'package:vzugruonvv/view/home.dart';
import 'package:vzugruonvv/view/pink.dart';

// onBackgroundMessage handler
// must be on created before void main()
Future<void> userDefinedFunction(RemoteMessage message) async {
  print(message.data.toString()); // parse the custom data to string
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // onBackgroundMessage - trigger the callback even if the app is open but minimized (background process)
  FirebaseMessaging.onBackgroundMessage(userDefinedFunction);

  runApp(PushNotifTest());
}

class PushNotifTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Home(),
        '/pink': (context) => Pink(),
        '/bluegrey': (context) => BlueGrey(),
      },
      initialRoute: '/',
    );
  }
}
