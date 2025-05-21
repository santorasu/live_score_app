import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.getInitialMessage();
    // foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      // Send local notification
      _handleNotification(message);
    });

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

  Future<String?> getFcmToken() async {
    // have to send token to database via login API
    return await FirebaseMessaging.instance.getToken();
  }

  void onTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken){
      // send new token to server
    });
  }
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // have to call API and save to local database

}
