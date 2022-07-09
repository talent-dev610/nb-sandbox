// import UIKit
// import Flutter
// import Firebase
// import UserNotifications

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   static func registerPlugins(with registry: FlutterPluginRegistry) {
//     GeneratedPluginRegistrant.register(with: registry)
//   }
    
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     FirebaseApp.configure()
//     AppDelegate.registerPlugins(with: self)
//     UNUserNotificationCenter.current().delegate = self
//     if #available(iOS 10.0, *) {
//       UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//     }
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
    
//     override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
//         {
//             completionHandler([.alert, .badge, .sound])
//         }
// }


import UIKit
import Flutter
import Firebase


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}