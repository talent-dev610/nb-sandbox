// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB76VRy50kfse2Y_fWBdjsHFitHLIVeGO8',
    appId: '1:1022786384184:web:ea73c510ee5c6927fc91cd',
    messagingSenderId: '1022786384184',
    projectId: 'nursebrain-sandbox',
    authDomain: 'nursebrain-sandbox.firebaseapp.com',
    storageBucket: 'nursebrain-sandbox.appspot.com',
    measurementId: 'G-0HMRKZSELB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDko0uasLXBSPLH0Hwa9A5hCK2dOXNqlPM',
    appId: '1:1022786384184:android:1380d7adb6d7e8ccfc91cd',
    messagingSenderId: '1022786384184',
    projectId: 'nursebrain-sandbox',
    storageBucket: 'nursebrain-sandbox.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXu2yo6rlyxI4_ToiVjz1NDZgHT__OXUI',
    appId: '1:1022786384184:ios:1c2cdcedb312452afc91cd',
    messagingSenderId: '1022786384184',
    projectId: 'nursebrain-sandbox',
    storageBucket: 'nursebrain-sandbox.appspot.com',
    androidClientId: '1022786384184-9qkpterrijh7uhcvkb0q10gv6rae9dfb.apps.googleusercontent.com',
    iosClientId: '1022786384184-5op1ioj6csgv8il9ksd6ivuoo2m9csnh.apps.googleusercontent.com',
    iosBundleId: 'com.nursebrain.sandbox',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXu2yo6rlyxI4_ToiVjz1NDZgHT__OXUI',
    appId: '1:1022786384184:ios:dbdaec03c6360cbbfc91cd',
    messagingSenderId: '1022786384184',
    projectId: 'nursebrain-sandbox',
    storageBucket: 'nursebrain-sandbox.appspot.com',
    androidClientId: '1022786384184-9qkpterrijh7uhcvkb0q10gv6rae9dfb.apps.googleusercontent.com',
    iosClientId: '1022786384184-680sa11hveq06r7jcef82ve3h1d5he2f.apps.googleusercontent.com',
    iosBundleId: 'samucreates.sbar',
  );
}
