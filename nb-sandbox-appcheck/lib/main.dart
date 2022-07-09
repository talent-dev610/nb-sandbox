import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sbarsmartbrainapp/screens/home/home.dart';
import 'package:sbarsmartbrainapp/services/firebase_analytics.dart';
import 'package:sbarsmartbrainapp/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_strategy/url_strategy.dart' as us;

import 'global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  us.setPathUrlStrategy();
  if (!UniversalPlatform.isWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // app security using app check
    await FirebaseAppCheck.instance.activate(
        // webRecaptchaSiteKey: '6LfKBX0gAAAAAKTFe1FfIRzP-SErYargwl9IvZBd',
        );
  }
  // get nursebrain package info

  // initializeLocalNotification();

  prefs = await SharedPreferences.getInstance();

  NotificationService.instance.start();

  runApp(MyApp());
}

// Local Notifications
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// initializeLocalNotification() async {
//   // Local notifications
//   var initializationSettingsAndroid =
//       new AndroidInitializationSettings('@mipmap/ic_launcher');
//   final IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings(
//           onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//   final MacOSInitializationSettings initializationSettingsMacOS =
//       MacOSInitializationSettings();
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//       macOS: initializationSettingsMacOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: selectNotification);
// }

// Future selectNotification(String payload) async {
//   print("'notification payload: $payload'");
// }

// Future onDidReceiveLocalNotification(
//     int id, String title, String body, String payload) async {
//   print("body: $body, title: $title");
//   print("'notification payload: $payload'");
//   CustomAnalytics().eventTodoNotification();
// }

// Primary Widget
class MyApp extends StatelessWidget {
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    try {
      String name = settings.name!;
      Uri? uri = Uri.tryParse(name);
      if (uri != null) {
        print('[_onGenerateRoute.path]${uri.path}');
        print('[_onGenerateRoute.queryParameters]${uri.queryParameters}');
        print('[_onGenerateRoute.pathSegments]${uri.pathSegments}');
        List<String> paths = uri.pathSegments;
        if (paths.isNotEmpty) {
          if (paths.first == 'signin-email-link') {
            String? token = uri.queryParameters['token'];
            // if (token != null) {
            //   Auth().signInWithEmail(token);
            // }
          }
        }
      }
    } catch (e) {
      print('[_onGenerateRoute]$e');
    }
    return MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
        settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    firebaseAnalytics.logAppOpen();
    return MaterialApp(
        title: 'NurseBrain® Application',
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
