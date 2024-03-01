import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseAPI {
  final firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/home',
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // FirebaseMessaging.onBackgroundMessage(
    //     (message) => handleBackgroundMessage(message));
  }

  Future<void> initNotifications() async {
    // requesting permision from the user
    // iOS -> show a dialog
    // Android -> return app notification are enabled or disabled
    await firebaseMessaging.requestPermission();

    // an identifier for our device in our apps to sending a notification
    // for a specific device
    // however in the real time apps, probably you want to save this token
    // somewhere in your db along with your user entity, so you can use it later
    GlobalUser.fCMToken = (await firebaseMessaging.getToken())!;
    print('Token: ${GlobalUser.fCMToken}');

    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    initPushNotifications();
  }
}
