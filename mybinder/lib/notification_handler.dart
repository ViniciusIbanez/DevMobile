
// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationHandler {

//   NotificationHandler._();

//   factory NotificationHandler() => _instance;

//   static final NotificationHandler _instance = NotificationHandler._();

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   bool _initialized = false;
//   String _token = "";

//   Future<void> init() async {
//     if (!_initialized) {
 
//       _firebaseMessaging.requestNotificationPermissions();
//       _firebaseMessaging.configure();

//       String token = await _firebaseMessaging.getToken();
//       print("FirebaseMessaging token: $token");
      
//       _initialized = true;
//       _token=token;
      
//     }
//   }
// }