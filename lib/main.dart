import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:fixupmoto/firebase_options.dart';
import 'package:fixupmoto/splash/reset_password.dart';
import 'package:fixupmoto/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/firebase_api.dart';
import 'package:fixupmoto/splash/splash_content.dart';
import 'package:fixupmoto/navbar/bottom_navbar.dart';
import 'package:fixupmoto/navbar/messages.dart';
import 'package:provider/provider.dart';
import 'package:fixupmoto/widget/carousel/notification_length_notifier.dart';

final navigatorKey = GlobalKey<NavigatorState>();

String? phone = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAPI().initNotifications();

  // runApp(const MyApp());
  runApp(
    ChangeNotifierProvider(
      create: (context) => NotificationLengthChangeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Fix Up Moto',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      routes: {
        '/init': (context) => const SplashContent(),
        '/home': (context) => const BottomNavBar(),
        '/notif': (context) => const Messages(),
        '/reset': (context) => const ResetPassword(),
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        // PointerDeviceKind.mouse,
      };
}
