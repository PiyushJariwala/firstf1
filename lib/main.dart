import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firstf1/screen/homepage.dart';
import 'package:firstf1/screen/login_sucsseful.dart';
import 'package:firstf1/screen/singup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

AndroidNotificationChannel channel =AndroidNotificationChannel("1","Android",importance: Importance.max);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');
  }

  FirebaseMessaging.onBackgroundMessage(_messageHandler);


  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/singUp': (context) => SignUpScreen(),
        '/logout':(context)=> Sucsses(),
      },
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    ),
  );
}
