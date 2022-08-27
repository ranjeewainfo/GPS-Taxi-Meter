import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_taxi_meter/splash_view.dart';

import 'remote_url_web_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

void subcribeGPSTaxi() async {
  await FirebaseMessaging.instance.subscribeToTopic("GPSTaxi").then((value) {});

  FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
    if (remoteMessage != null) {
      navigateURL(remoteMessage.data['home'], true);
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'key1',
            title: message.notification?.title,
            body: message.notification?.body));

    navigateURL(message.data['home'], false);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    navigateURL(message.data['home'], true);
  });
}

navigateURL(String url, bool shouldGoHome) {
  Get.to(RemoteURLWebView(
    url: url,
    shouldGoHome: shouldGoHome,
  ));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  subcribeGPSTaxi();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AwesomeNotifications().initialize(
    'resource://mipmap/ic_launcher',
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'key1',
          channelName: 'Basic notifications',
          channelDescription: 'GPS Taximeter',
          defaultColor: Color(0xFF9D50DD),
          channelShowBadge: true,
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupkey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
    debug: true,
  );

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
