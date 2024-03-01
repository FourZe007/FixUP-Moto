// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/splash/reset_verification.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_title_static.dart';
import 'package:fixupmoto/widget/textfield.dart/customxuserinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String pass = '';
  String? phoneSharedPrefs = '';

  List<ModelUser> listLogin = [];

  void setPass(String value) {
    pass = value;
  }

  void setNewPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneSharedPrefs = prefs.getString('phonenumber');

    if (phoneSharedPrefs!.isEmpty) {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'WARNING!',
          message: 'Please enter your phone number first',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetVerification(phoneSharedPrefs!),
        ),
      );
    }
  }

  void login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalUser.phone = prefs.getString('phonenumber');

    if (GlobalUser.phone != '' && pass != '') {
      setState(() => GlobalVar.isLoading = true);
      listLogin = await GlobalAPI.loginAccount(GlobalUser.phone!, pass);

      // kasih pengecekan kl pass salah apa ga!
      if (listLogin[0].memo == 'SUKSES') {
        await prefs.setString('password', pass);
        await prefs.setString('id', listLogin[0].memberID);
        await prefs.setBool('userstate', true);

        if (listLogin[0].flag == 0) {
          GlobalUser.flag = 0;
          await prefs.setInt('flag', 0);
        } else {
          GlobalUser.flag = 1;
          await prefs.setInt('flag', 1);
        }

        print('GlobalUser Flag: ${GlobalUser.flag}');

        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'LOGIN SUCCESS!',
            message: 'Please wait for a moment',

            /// change contentType to ContentType.success,
            /// ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        // print(listlogin[0].memo);

        setState(() => GlobalVar.isLoading = false);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() => GlobalVar.isLoading = true);
        // REGISTER
        GlobalVar.loginAlert = 'PASSWORD SALAH';
        setState(() => GlobalVar.isLoading = false);
      }
    } else {
      setState(() => GlobalVar.isLoading = true);
      GlobalVar.loginAlert = 'PERIKSA KEMBALI INPUT ANDA';
      setState(() => GlobalVar.isLoading = false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    GlobalVar.loginAlert = '';

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      child: WillPopScope(
        onWillPop: () async {
          // Prevent the default back button behavior
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              width: 15.0,
              height: 15.0,
              margin: const EdgeInsets.only(top: 10.0, left: 10.0),
              padding: const EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                //replace with our own icon data.
              ),
            ),
          ),
          body: Container(
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
                    height: MediaQuery.of(context).size.height * 0.825,
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
                                top: MediaQuery.of(context).size.height * 0.135,
                              ),
                              child: LabelTitleStatic(
                                'ENTER PASSWORD',
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
                                'Fill the password field to sign in',
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
                              setPass,
                              pass,
                              mode: 0,
                              isPass: true,
                              hint: 'password',
                              icon: Icons.lock,
                              autoFocus: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.035,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                GlobalVar.loginAlert,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: setNewPass,
                                child: Text(
                                  'Forgot Password?',
                                  style: GlobalFont.mediumBigfontRTextButton,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GlobalVar.isLoading
                                ? const CircleLoading()
                                : Tombol(
                                    'SIGN IN',
                                    login,
                                    lebar:
                                        MediaQuery.of(context).size.width * 0.9,
                                  ),
                          ],
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
