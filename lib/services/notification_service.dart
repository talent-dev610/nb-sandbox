import 'dart:convert';
import 'dart:io' as IO;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:universal_platform/universal_platform.dart';

class NotificationService {
  /// We want singelton object of ``NotificationService`` so create private constructor
  /// Use NotificationService as ``NotificationService.instance``
  NotificationService._internal();

  static final NotificationService instance = NotificationService._internal();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();

  /// For local_notification id
  int _count = 0;

  /// ``NotificationService`` started or not.
  /// to start ``NotificationService`` call start method
  bool _started = false;

  /// Call this method on startup
  /// This method will initialise notification settings
  void start() {
    if (!_started) {
      _integrateNotification();
      _refreshToken();
      _started = true;
    }
  }

  // Call this method to initialize notification

  void _integrateNotification() {
    _askForPermission();
    _registerNotification();
    _initializeLocalNotification();
  }

  void _askForPermission() {
    if (UniversalPlatform.isIOS) {
      _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions(
            alert: false,
            badge: true,
            sound: true,
          );
    } else {
      _firebaseMessaging.requestPermission();
    }
  }

  /// initialize firebase_messaging plugin
  void _registerNotification() {
    /// App in foreground -> [onMessage] callback will be called
    /// App terminated -> Notification is delivered to system tray. When the user clicks on it to open app [onLaunch] fires
    /// App in background -> Notification is delivered to system tray. When the user clicks on it to open app [onResume] fires

    FirebaseMessaging.onMessage.listen((event) {
      Map<String, dynamic> notificationObject = {
        "notification": {
          "title": event.notification!.title,
          "body": event.notification!.body,
          "image_url": ((UniversalPlatform.isAndroid
                  ? event.notification!.android!.imageUrl
                  : event.notification!.apple!.imageUrl) ??
              "")
        },
        "data": event.data
      };
      print('--------------- open');
      print(event.notification!.title);
      _onMessage(notificationObject);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Map<String, dynamic> notificationObject = {
        "notification": {
          "title": event.notification!.title,
          "body": event.notification!.body,
          "image_url": ((UniversalPlatform.isAndroid
                  ? event.notification!.android!.imageUrl
                  : event.notification!.apple!.imageUrl) ??
              "")
        },
        "data": event.data
      };
      _onLaunch(notificationObject);
    });

    FirebaseMessaging.onBackgroundMessage((event) async {
      Map<String, dynamic> notificationObject = {
        "notification": {
          "title": event.notification!.title,
          "body": event.notification!.body,
          "image_url": ((UniversalPlatform.isAndroid
                  ? event.notification!.android!.imageUrl
                  : event.notification!.apple!.imageUrl) ??
              "")
        },
        "data": event.data
      };
      print('--------------- background');
      _onResume(notificationObject);
    });

    _firebaseMessaging.onTokenRefresh
        .listen(_tokenRefresh, onError: _tokenRefreshFailure);
  }

  /// Token is unique identity of the device.
  /// Token is required when you want to send notification to perticular user.
  void _refreshToken() {
    _firebaseMessaging.getToken().then((token) async {
      // print('token: $token');
    }, onError: _tokenRefreshFailure);
  }

  /// This method will be called device token get refreshed
  void _tokenRefresh(String newToken) async {
    print('New Token : $newToken');
  }

  void _tokenRefreshFailure(error) {
    print("FCM token refresh failed with error $error");
  }

  /// This method will be called on tap of the notification which came when app was in foreground
  ///
  /// Firebase messaging does not push notification in notification panel when app is in foreground.
  /// To send the notification when app is in foreground we will use flutter_local_notification
  /// to send notification which will behave similar to firebase notification
  Future<void> _onMessage(Map<String, dynamic> message) async {
    print('onMessage: $message');
    if (message['notification']['image_url'] != "" &&
        message['notification']['image_url'] != null) {
      print('-------showing notification with attachment-------');
      showNotificationWithAttachment(message);
    } else {
      print('-------showing simple notification ---------');
      _showNotification(
        {
          "title": message['notification']['title'],
          "body": message['notification']['body'],
          "data": message['data'],
        },
      );
    }
  }

  /// This method will be called on tap of the notification which came when app was closed
  Future<void>? _onLaunch(Map<String, dynamic> message) {
    print('onLaunch: $message');
    return null;
  }

  /// This method will be called on tap of the notification which came when app was in background
  Future<void> _onResume(Map<String, dynamic> message) async {
    print('onResume: $message');
    if (message['notification']['image_url'] != "" &&
        message['notification']['image_url'] != null) {
      print('-------showing notification with attachment-------');
      showNotificationWithAttachment(message);
    } else {
      print('-------showing simple notification ---------');
      _showNotification(
        {
          "title": message['notification']['title'],
          "body": message['notification']['body'],
          "data": message['data'],
        },
      );
    }
  }

  Future<void> showNotificationWithAttachment(
      Map<String, dynamic> notification) async {
    var attachmentPicturePath = await _downloadAndSaveFile(
        notification['notification']['image_url'], 'attachment_img.jpg');
    print('-----file downloaded at path : $attachmentPicturePath');
    var iOSPlatformSpecifics = IOSNotificationDetails(
      attachments: [IOSNotificationAttachment(attachmentPicturePath)],
    );
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachmentPicturePath),
      contentTitle: '<b>Attached Image</b>',
      htmlFormatContentTitle: true,
      summaryText: 'Image',
      htmlFormatSummaryText: true,
    );
    var androidChannelSpecifics = AndroidNotificationDetails(
      'channelId',
      'channelDescription',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    var notificationDetails = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
    print('-----showing----');
    print('--title ${notification['notification']['title']}');
    print('--body ${notification['notification']['body']}');
    await _flutterLocalNotificationsPlugin.show(
      ++_count,
      notification['notification']['title'],
      notification['notification']['body'],
      notificationDetails,
    );
  }

  _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = IO.File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  /// used for sending push notification when app is in foreground
  void _showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelId', 'channelDescription',
        priority: Priority.high, importance: Importance.max);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      ++_count,
      message['title'],
      message['body'],
      platformChannelSpecifics,
      payload: json.encode(
        message['data'],
      ),
    );
  }

  // / initialize flutter_local_notification plugin
  void _initializeLocalNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title, body: body, payload: payload);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );
    // print('-----initilization---');
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // // Settings for Android
    // var androidInitializationSettings =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');
    // // Settings for iOS
    // var iosInitializationSettings = new IOSInitializationSettings();
    // _flutterLocalNotificationsPlugin.initialize(
    //   InitializationSettings(
    //     android: androidInitializationSettings,
    //     iOS: iosInitializationSettings,
    //   ),
    //   onSelectNotification: _onSelectLocalNotification,
    // );
  }

  /// This method will be called on tap of notification pushed by flutter_local_notification plugin when app is in foreground
  Future? _onSelectLocalNotification(String payLoad) {
    Map? data = json.decode(payLoad);
    Map<String, dynamic> message = {
      "data": data,
    };
    return null;
  }
}

class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });
}
