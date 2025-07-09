// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:injectable/injectable.dart';
// import 'package:rxdart/utils.dart';

// abstract class INotificationProvider {
//   Future<bool> init();
//   void dispose();
// }

// @singleton
// class NotificationProvider extends INotificationProvider {
//   FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
//   CompositeSubscription compositeSubscription = CompositeSubscription();
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   bool isInitialized = false;

//   @override
//   Future<bool> init() async {
//     try {
//       if (isInitialized) {
//         log('NotificationProvider is already initialized');
//         return true;
//       }
//       final _ = await firebaseMessaging.requestPermission(provisional: true);

//       const AndroidInitializationSettings androidInitSettings =
//           AndroidInitializationSettings('@mipmap/ic_launcher');

//       const DarwinInitializationSettings iosInitSettings =
//           DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//       );

//       const InitializationSettings initSettings = InitializationSettings(
//           android: androidInitSettings, iOS: iosInitSettings);

//       flutterLocalNotificationsPlugin.initialize(
//         initSettings,
//         onDidReceiveNotificationResponse: (data) async {
//           final payload =
//               data.payload != null ? json.decode(data.payload!) : {};
//           if (payload["event"] == 'new_message_alert') {
//             _onNewMessageAlert();
//           }
//         },
//       );

//       if (Platform.isIOS) {
//         final apnsToken = await firebaseMessaging.getAPNSToken();
//         if (apnsToken != null) {
//           _onTokenListener();
//         }
//       } else {
//         _onTokenListener();
//       }

//       _onOpenedAppListener();
//       isInitialized = true;
//       return true;
//     } catch (e, s) {
//       log('Error initializing Firebase Messaging: $e', error: e, stackTrace: s);
//     }

//     return false;
//   }

//   void _onTokenListener() {
//     firebaseMessaging.getToken().then((String? token) {
//       if (token != null) {
//         _updateFcmToken(token);
//       } else {
//         log('Firebase Messaging token is null');
//       }
//     }).catchError((error) {
//       log('Error getting Firebase Messaging token: $error');
//     });
//     firebaseMessaging.onTokenRefresh.listen((String token) {
//       _updateFcmToken(token);
//     }).addTo(compositeSubscription);
//   }

//   void _onOpenedAppListener() {
//     firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         if (message.data['event'] == 'new_message_alert') {
//           _onNewMessageAlert();
//         }
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (message.data['event'] == 'new_message_alert') {
//         _onNewMessageAlert();
//       }
//     }).addTo(compositeSubscription);

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.data['event'] == 'new_message_alert') {
//         _showNotification(
//           title: message.notification?.title ?? 'New Message',
//           body: message.notification?.body ?? 'You have a new message.',
//           payload: message.data,
//         );
//       } else {
//         log('Received message with unknown event: ${message.data['event']}');
//       }
//     }).addTo(compositeSubscription);
//   }

//   _onNewMessageAlert() {}

//   void _updateFcmToken(String token) {}

//   Future<void> _showNotification({
//     required String title,
//     required String body,
//     Map<String, dynamic>? payload,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'message_channel',
//       'Message Notifications',
//       channelDescription: 'Channel for message alerts',
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformDetails,
//       payload: payload != null ? json.encode(payload) : null,
//     );
//   }

//   @override
//   void dispose() {
//     compositeSubscription.dispose();
//   }
// }
