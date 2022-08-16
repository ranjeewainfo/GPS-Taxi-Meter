import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gps_taxi_meter/splash_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.data}');
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

void subcribeGPSTaxi() async {
  await FirebaseMessaging.instance
      .subscribeToTopic("GPSTaxi")
      .then((value) => print("GPSTaxi subscribed"));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'key1',
            title: message.notification?.title,
            body: message.notification?.body));
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  subcribeGPSTaxi();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'key1',
            channelName: 'Basic notifications',
            channelDescription: 'GPS Taximeter',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
