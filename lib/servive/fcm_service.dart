import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.getInitialMessage();
    // foreground state
    FirebaseMessaging.onMessage.listen(_handleNotification);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);

    // background state
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }
    void _handleNotification(RemoteMessage message) async {
      String formatedMessage = '''
      Title: ${message.notification?.title}
      Body: ${message.notification?.body}
      Data: ${message.data}
      ''';
      print(formatedMessage);
    }

  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {

  }



