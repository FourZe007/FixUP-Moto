// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixupmoto/account/login.dart';
import 'package:fixupmoto/account/term_condition.dart';
import 'package:fixupmoto/account/verify.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_title_static.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/widget/textfield.dart/customxuserinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';

class SplashContent extends StatefulWidget {
  const SplashContent({super.key});

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  // final ScrollController _scrollController = ScrollController();
  // bool _isScrolledToEnd = false;
  String phone = '';
  String pass = '';
  bool isChecked = false;

  List<ModelUser> listLogin = [];

  String token = '';

  void setPhone(String value) {
    phone = value;
  }

  void setPass(String value) {
    pass = value;
  }

  void getUserAccess() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // loginState = prefs.getInt('flag');
    GlobalUser.flag = prefs.getInt('flag');
    GlobalUser.isNew = prefs.getBool('isnew');
    if (GlobalUser.flag == null && GlobalUser.isNew == null) {
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
  }

  void warn() {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'WARNING!',
        message: 'Mohon menyetujui pernyataan dan persetujuan terlebih dahulu',

        /// change contentType to ContentType.success,
        /// ContentType.warning or ContentType.help for variants
        contentType: ContentType.warning,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String substring1 = phone.split('8')[0];

    if (phone != '' && substring1 != '0') {
      await prefs.setString('phonenumber', phone);

      listLogin = await GlobalAPI.loginAccount(phone, '00000');

      if (listLogin[0].flag == 2) {
        // no telp tidak terdaftar
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerifyAccount(),
            // builder: (context) => Register(true),
          ),
        );
      } else if (listLogin[0].flag == 0) {
        // no telp sudah terdaftar
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
            // builder: (context) => const VerifyAccount(),
          ),
        );
      }
    } else {
      // snackbar cek inputan && format nomor telp
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'FAILED!',
          message: 'Please check your input again',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  void checkLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString('id');
    String? phone = prefs.getString('phonenumber');
    String? pass = prefs.getString('password');
    int? flag = prefs.getInt('flag');

    if (id != '' && phone != '' && pass != '' && flag != 0) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    GlobalVar.loginAlert = '';
    phone = '';
    // _scrollController.addListener(_scrollListener);
    // isNewDevice();

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    GlobalVar.loginAlert = '';
    phone = '';
    // _scrollController.removeListener(_scrollListener);
    // _scrollController.dispose();

    // phone = '';
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalVar.isLoading = false;

    return DoubleTapToExit(
      snackBar: SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'WARNING!',
          message: 'Tap again to exit',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            // New
            // Remove back button to make the UI/UX more clean
            automaticallyImplyLeading: false,
            // New
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            // color: Colors.white,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('./assets/login-background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: (GlobalUser.isNew == true && GlobalUser.flag == 0)
                        ? MediaQuery.of(context).size.height * 0.86
                        : MediaQuery.of(context).size.height * 0.925,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.125,
                              ),
                              child: LabelTitleStatic(
                                'LOGIN OR REGISTER',
                                GlobalFont.titleLoginFontW2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04,
                              ),
                              child: const Text(
                                'Enter your phone number to login or register',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomUserInput(
                              setPhone,
                              phone,
                              mode: 0,
                              isPhone: true,
                              prefixText: '+62',
                              hint: 'nomor telepon',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: (GlobalUser.isNew == true && GlobalUser.flag == 0)
                        ? MediaQuery.of(context).size.height * 0.14
                        : MediaQuery.of(context).size.height * 0.075,
                    decoration: BoxDecoration(
                      color: (GlobalUser.isNew == true && GlobalUser.flag == 0)
                          ? Colors.white70
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // New
                        // before using (GlobalUser.isNew == true && GlobalUser.flag == 0) statement
                        (GlobalUser.isNew == true)
                            ? Container(
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.01,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                (Set<MaterialState> states) {
                                          // const Set<MaterialState>
                                          //     interactiveStates =
                                          //     <MaterialState>{
                                          //   MaterialState.pressed,
                                          //   MaterialState.hovered,
                                          //   MaterialState.focused,
                                          // };
                                          // if (states.any(
                                          //     interactiveStates.contains)) {
                                          //   return Colors.blue;
                                          // }
                                          return Colors.black;
                                        }),
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          print('Before: $isChecked');
                                          setState(() {
                                            isChecked = !isChecked;
                                          });
                                          print('After: $isChecked');
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Saya menyetujui ',
                                              style: GlobalFont.bigfontMNormal,
                                            ),
                                            TextSpan(
                                              text: 'syarat dan ketentuan',
                                              style: GlobalFont.bigfontMNormal
                                                  .copyWith(
                                                color: Colors.blue[
                                                    800], // Or any desired color
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TermsAndConditions(), // Replace with the actual page
                                                    ),
                                                  );
                                                },
                                            ),
                                            TextSpan(
                                              text: ' aplikasi FixUP Moto',
                                              style: GlobalFont.bigfontMNormal,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(height: 0.0),
                        GlobalVar.isLoading
                            ? const CircleLoading(warna: Colors.white)
                            : isChecked == true || GlobalUser.isNew == false
                                ? Tombol(
                                    'CONTINUE',
                                    login,
                                    lebar: MediaQuery.of(context).size.width *
                                        0.95,
                                  )
                                : Tombol(
                                    'CONTINUE',
                                    warn,
                                    lebar: MediaQuery.of(context).size.width *
                                        0.95,
                                    disable: true,
                                  ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
