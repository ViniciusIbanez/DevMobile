import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHandler {
  NotificationHandler._();

  factory NotificationHandler() => _instance;

  static final NotificationHandler _instance = NotificationHandler._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;
  String _token = "";

  Future<void> init() async {
    if (!_initialized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("Recieved message");
      });
    }
  }
}
