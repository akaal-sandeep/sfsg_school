//import UIKit
//import Flutter
//import Firebase
//
//@UIApplicationMain
//@objc class AppDelegate: FlutterAppDelegate {
//  override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//    GeneratedPluginRegistrant.register(with: self)
//      if FirebaseApp.app() == nil {
//             FirebaseApp.configure()
//          //------
//          GeneratedPluginRegistrant.register(with: self)
//              if #available(iOS 14.0, *) {
//                  // For iOS 10 display notification (sent via APNS)
//                  UNUserNotificationCenter.current().delegate = self
//                  let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//                  UNUserNotificationCenter.current().requestAuthorization(
//                          options: authOptions,
//                          completionHandler: {_, _ in })
//              } else {
//                  let settings: UIUserNotificationSettings =
//                  UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//                  application.registerUserNotificationSettings(settings)
//              }
//          //------
//         }
//     // FirebaseApp.configure()
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//  }
//}

import UIKit
import Flutter
import GoogleMaps
import Firebase // Add this import
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate  {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GMSServices.provideAPIKey("AIzaSyBhN7K2pQYAlxY7bQlqzSf6YUpLKkBhLrI")
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 14.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
    } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
