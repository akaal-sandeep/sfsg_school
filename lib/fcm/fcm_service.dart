import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import '../constants/string_constants.dart';
import '../local_storage/local_storage.dart';
import '../parent_model/get_student_list_r1_model.dart';


// ignore: slash_for_doc_comments
/**
 * Documents added by Alaa, enjoy ^-^:
 * There are 3 major things to consider when dealing with push notification :
 * - Creating the notification
 * - Hanldle notification click
 * - App status (foreground/background and killed(Terminated))
 *
 * Creating the notification:
 *
 * - When the app is killed or in background state, creating the notification is handled through the back-end services.
 *   When the app is in the foreground, we have full control of the notification. so in this case we build the notification from scratch.
 *
 * Handle notification click:
 *
 * - When the app is killed, there is a function called getInitialMessage which
 *   returns the remoteMessage in case we receive a notification otherwise returns null.
 *   It can be called at any point of the application (Preferred to be after defining GetMaterialApp so that we can go to any screen without getting any errors)
 * - When the app is in the background, there is a function called onMessageOpenedApp which is called when user clicks on the notification.
 *   It returns the remoteMessage.
 * - When the app is in the foreground, there is a function flutterLocalNotificationsPlugin, is passes a future function called onSelectNotification which
 *   is called when user clicks on the notification.
 *
 * */
class PushNotificationService {

  RemoteMessage? _remoteMessage;
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
// Get any messages which caused the application to open from a terminated state.
    // If you want to handle a notification click when the app is terminated, you can use `getInitialMessage`
    // to get the initial message, and depending in the remoteMessage, you can decide to handle the click
    // This function can be called from anywhere in your app, there is an example in main file.
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // // If the message also contains a data property with a "type" of "chat",
    // // navigate to a chat screen
    // if (initialMessage != null && initialMessage.data['key'] == 'background') {
    //   consolePrint(label: "data",data: initialMessage.data.toString());
    //   Get.to(()=>Second());
    // }
// Also handle any interaction when the app is in the background via a
    // Stream listener
    // This function is called when the app is in the background and user clicks on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Get.toNamed(NOTIFICATIOINS_ROUTE);
     onPressNavigation(message);
    });
    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
      );
// onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
         _remoteMessage = message;
        myLog(label: "notification ", value: message?.data.toString());

      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(

            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
              playSound: true,
            ),
          ),
        );
      }
    });

  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  androidNotificationChannel() => AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title// description
    importance: Importance.max,
  );
}

onPressNavigation(RemoteMessage remoteMessage){
  StudentData studentData= StudentData.fromJson(jsonDecode(remoteMessage.data['user']));
  LocalStorage().writeModel(key: StringConstants.parentProfileModel, model: studentData);

  switch(remoteMessage.data['type']){
    case "1":ParentController().getClassHomeWorkWithReadStatus();
         break;
    case "2":ParentController().getLessonPlanListForStudent();
          break;
  }
  // ParentController().getClassHomeWorkWithReadStatus();
}

/// In background this function will work
/// do it on splash
checkSplash() async {
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null && initialMessage.data['key'] == 'background') {

  }
}

///data is important when you want notification in your app in background and terminate state
///
/// Important
/// api structure for notification
// {
//   "to" : "eADebHzUQgiHtrgJtkwMyp:APA91bGJj825DPLjDVM2-tGhejso3e4p_moo65bo_C6gFqrKBxsGMciboXs2Yh3ihrJuftDPlBK_evxk1yl8U9iEtxqiPuyA9U7yIRwugH6ImKMPoculQyxaHH7W9XmjwYF5Ifye4GjG",
//   "collapse_key" : "type_a",
//   "priority": 10,
//   "data" : {
//     "body" : "Notification",
//     "title": "Notification title",
//     "key":"background"
//     },
//     "notification":{
//       "title":"Hi from Postman ",
//       "body":"great match!"
//     }
// }
///receive data into message
///theory:
///when open doesn't open after click on notification. It's because of "collapseKey"  which we receive in message object
///collapseKey contain application id so that with the help of that application got open
//  {
//   "senderId": "null",
//   "category": "null",
//   "collapseKey": "com.example.notification",
//   "contentAvailable": "false",
//   "data": {
//     "body": "Notification",
//     "title": "Notification title",
//     "key": "background"
//   },
//   "from": "195859514104",
//   "messageId": "0:1654954051033981%7cc2053c7cc2053c",
//   "messageType": "null",
//   "mutableContent": false,
//   "notification": {
//     "title": "Hi from Postman",
//     "titleLocArgs": [],
//     "titleLocKey": null,
//     "body": " great match!",
//     "bodyLocArgs": [],
//     "bodyLocKey": "null",
//     "android": {
//       "channelId": null,
//       "clickAction": null,
//       "color": null,
//       "count": null,
//       "imageUrl": null,
//       "link": null,
//       "priority": 0,
//       "smallIcon": null,
//       "sound": null,
//       "ticker": null,
//       "tag": null,
//       "visibility": 0
//     },
//     "apple": null,
//     "web": null
//   },
//   "sentTime": 1654954051016,
//   "threadId": null,
//   "ttl": 2419200
// }