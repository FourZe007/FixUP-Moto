import 'package:fixupmoto/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? loginState = 0;

  void getUserAccess() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // loginState = prefs.getInt('flag');
    GlobalUser.flag = prefs.getInt('flag');
    GlobalUser.isNew = prefs.getBool('isnew');
    if (GlobalUser.flag == null && GlobalUser.isNew == null) {
      prefs.clear();
      GlobalUser.flag = 0;
      GlobalUser.isNew = true;
    }

    print('Splash Screen Flag: ${GlobalUser.flag}');
    // print('Splash Screen Login State: $loginState');
    print('Splash Screen isNew: ${GlobalUser.isNew}');
    if (GlobalUser.flag == 0 && GlobalUser.isNew == true) {
      await prefs.setBool('isnew', true);
      await prefs.setInt('flag', 0);
    } else {
      await prefs.setBool('isnew', false);
    }

    // temporary source code - My own source code
    // GlobalFunction.getAppVersion().then((appVer) async {
    //   print('Splash Screen - App Version: ${GlobalVar.appVersion}');

    //   if (GlobalVar.currentAppVersion == '') {
    //     GlobalVar.currentAppVersion = appVer;
    //     print(
    //         'Splash Screen - Current App Version: ${GlobalVar.currentAppVersion}');
    //     await prefs.setString('version', appVer);
    //   } else {
    //     final SharedPreferences prefs = await SharedPreferences.getInstance();
    //     GlobalVar.appVersion = prefs.getString('version')!;
    //     if (GlobalVar.appVersion != GlobalVar.currentAppVersion) {}
    //   }
    //   // print(
    //   //     'Splash Screen - Current App Version: ${GlobalVar.currentAppVersion}');
    // });

    // print('Splash Screen - App Version: ${GlobalVar.appVersion}');
    // print(
    //     'Splash Screen - Current App Version: ${GlobalVar.currentAppVersion}');
    // GlobalFunction.getAppVersion();
    // if (GlobalVar.currentAppVersion == '') {
    //   GlobalVar.currentAppVersion = GlobalVar.appVersion;
    // }
    // setState(() {});
    // await prefs.setString('version', GlobalVar.appVersion);
  }

  @override
  void initState() {
    getUserAccess();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
        context,
        GlobalUser.flag == 1 ? '/home' : '/init',
      );
    });

    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFE0000),
      ),
      sized: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFFE0000),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: const DecorationImage(
                image: AssetImage('assets/fixup logo.jpg'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
