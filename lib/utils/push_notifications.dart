// import 'dart:developer';
// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:pigemshubshop/app/common/pi_debug_print.dart';
// import 'package:pigemshubshop/app/common/storage/shared_pref.dart';
// import 'package:pigemshubshop/app/constants/shared_pref_const.dart';
//
// class PiPushNotifications {
//   static int count = 0;
//
//   PiPushNotifications._();
//
//   factory PiPushNotifications() => _instance;
//
//   static final PiPushNotifications _instance = PiPushNotifications._();
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   bool _initialized = false;
//
//   Future<void> init() async {
//     if (!_initialized) {
//       count = 0;
//
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true, // Required to display a heads up notification
//         badge: true,
//         sound: true,
//       );
//
//       NotificationSettings settings =
//           await _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//
//       String token = (await _firebaseMessaging.getToken())!;
//
//       SharedPref().setString(SharedPrefConstant.setFcmToken, value: token);
//
//       log("### FCM token: PiPushNotifications : $token");
//
//       if (Platform.isAndroid) {
//         // MoEngageService.sendTokenToMoEngageAndroid(token: token);
//
//         _firebaseMessaging.getToken().then((value) {
//           print("======DEVICE TOKEN IS $value");
//         });
//
//         _firebaseMessaging.getInitialMessage().then((value) {
//           print(
//               "=======InitialMessage IS ${value?.data ?? "Null Value getInitialMessage"}");
//           print("=======InitialMessage IS ${value?.category}");
//         });
//
//         _firebaseMessaging.isSupported().then((value) {
//           print("=======isSupported IS $value");
//         });
//
//         FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//           print("=======Remote Message : ${message.data}");
//           message.data.piPrint();
//         });
//       }
//
//       Stream<String> tokenStream = _firebaseMessaging.onTokenRefresh;
//
//       tokenStream.listen((event) async {
//         if (Platform.isAndroid) {
//           // MoEngageService.sendTokenToMoEngageAndroid(token: token);
//
//           tokenStream.piPrint();
//
//           SharedPref().setString(SharedPrefConstant.setFcmToken, value: token);
//         }
//         log("### FCM token:: $token");
//       });
//
//       _initialized = true;
//     }
//   }
//
//   void firebaseMessagingConfigure() async {
//
//
//
//   }
//
//
//   ///for Admin SDK and API use case
//   void updateFCMToken() async {
//     String platform = '';
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         platform = 'Android';
//         break;
//       case TargetPlatform.fuchsia:
//         platform = 'Fuchsia';
//         break;
//       case TargetPlatform.iOS:
//         platform = 'iOS';
//         break;
//       case TargetPlatform.linux:
//         platform = 'Desktop';
//         break;
//       case TargetPlatform.macOS:
//         platform = 'Desktop';
//         break;
//       case TargetPlatform.windows:
//         platform = 'Desktop';
//         break;
//     }
//     try {
//       var body = {
//         "platform": platform,
//         // "device_id": await PlatformDeviceId.getDeviceId,
//         "fcm_token": await FirebaseMessaging.instance.getToken()
//       };
//     } catch (e) {}
//   }
// }
/// This is root widget Init Code
// void getNotification() async {
//   var initAndroidSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");
//
//   var initializationSetting = InitializationSettings(
//     android: initAndroidSettings,
//   );
//
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   flutterLocalNotificationsPlugin.initialize(initializationSetting);
//
//   getFcmListen();
// }
//
// Future<bool> getLocalFcmToken() async {
//   final String? token =
//   await SharedPref().getString(SharedPrefConstant.setFcmToken);
//   if (token != null && token.isNotEmpty) {
//     "The Token is there is DataBase".piPrint();
//     return true;
//   } else {
//     "The Token is NOT there is DataBase".piPrint();
//
//     return false;
//   }
// }
//
// void getFcmListen() async {
//   _fcm.listen((RemoteMessage message) async {
//     final bool tokenExist = await getLocalFcmToken();
//     if (tokenExist) {
//       if (Platform.isAndroid) {
//         final data = message.data;
//         String notificationTitle = message.notification?.title ?? "";
//         String notificationBody = message.notification?.body ?? "";
//
//         log("### ------------- Before -------------------");
//         log("### notificationTitle: $notificationTitle");
//         log("### notificationBody: $notificationBody");
//         log("### data: $data");
//         log("### data runtimeType: ${data.runtimeType}");
//         log("### ------------- After -------------------");
//
//         await _showNotification(notificationTitle, notificationBody);
//
//         PiPushNotifications.count++;
//         PiPushNotifications.count.piPrint();
//       }
//     } else {
//       setState(() {
//         notificationInfo = message;
//       });
//     }
//   });
// }
//
// Future<void> _showNotification(String title, String body) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
//     channelDescription: 'your channel description',
//     importance: Importance.max,
//     priority: Priority.high,
//     ticker: 'ticker',
//   );
//
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   await flutterLocalNotificationsPlugin.show(
//       0, title, body, platformChannelSpecifics);
// }