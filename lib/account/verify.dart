import 'dart:async';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/account/register.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_title_static.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyAccount extends StatefulWidget {
  const VerifyAccount({super.key});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  int randomNumber = 0;
  int _remainingDuration = 60;
  Timer? _timer;
  ModelSendOTP mapSendOTP = ModelSendOTP(resultMessage: '');
  bool isVerified = false;
  bool isRun = false;
  String otp = '';

  void verify() {
    // setState(() => isLoading = true);
    print('Random Number: ${randomNumber.toString()}');
    print('User OTP: $otp');
    if (randomNumber.toString() == otp) {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'OTP VERIFIED',
          message: 'Please wait for a moment',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      isVerified = true;
      setState(() {
        GlobalVar.registerAlert = "OTP is verified";
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(isVerified),
        ),
      );
    } else {
      isVerified = false;
      setState(() {
        GlobalVar.registerAlert = "Invalid OTP";
      });
    }
    setState(() => isVerified);

    // setState(() => isLoading = false);
    // Navigator.pop(context);
  }

  void setRandomNumber() {
    // Generate a random number between 1,000 and 9,999
    randomNumber = Random().nextInt(9000) + 1000;

    // Prints the random number, for example: 5,912
    print('Random Number: $randomNumber');
  }

  void sendOTP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalUser.phone = prefs.getString('phonenumber');

    print('Sent OTP');

    if (GlobalUser.phone != '') {
      setRandomNumber();
      // give warning if the phone format was wrong
      // NEW
      String message =
          '[FIXUP MOTO] ${randomNumber.toString()} adalah kode registrasi Anda. Demi Keamanan, jangan bagikan kode ini. Kode ini kadaluarsa dalam 1 menit.';
      mapSendOTP = await GlobalAPI.fetchSendOTP(
        '62${GlobalUser.phone}',
        message,
        'poco-phone',
        // 'realme-tab',
        'text',
      );

      print('Send OTP result: ${mapSendOTP.resultMessage}');

      if (mapSendOTP.resultMessage == 'pending') {
        setState(() {
          GlobalVar.registerAlert = "Kode OTP berhasil dikirim";
        });

        _remainingDuration = 60;
        _startTimer();
      } else {
        setState(() {
          GlobalVar.registerAlert = "Kode OTP gagal dikirim";
        });
      }
    } else {
      setState(() {
        GlobalVar.registerAlert = "Periksa kembali input anda";
      });
    }
  }

  void _startTimer() async {
    // NEW
    // sblmnya di dalam if (_remainingDuration > 0)
    setState(() => isRun = true);
    // NEW

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (isVerified == false) {
          if (_remainingDuration > 0) {
            print('Remaining Timer: $_remainingDuration');
            setState(() {
              _remainingDuration--;
            });
          } else {
            timer.cancel();
            // Handle countdown completion here, such as displaying a message or performing an action
            setState(() {
              _remainingDuration = 0;
              randomNumber = 0;
            });
            // setRandomNumber();
            GlobalVar.registerAlert = "OTP Code expired";
            setState(() => isRun = false);
            print('Countdown completed');
          }
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setRandomNumber();
    sendOTP();
  }

  @override
  void dispose() {
    _timer?.cancel();
    otp = '';
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
          appBar: AppBar(
            // backgroundColor: Colors.white,
            // backgroundColor: const Color(0xFFFE0000),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
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
                    // color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.67,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LabelTitleStatic(
                              'VERIFICATION',
                              GlobalFont.titleLoginFontW2,
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
                                'Please enter your verification code from Whatsapp',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            OTPTextField(
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 80,
                              style: const TextStyle(fontSize: 17),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.underline,
                              onChanged: (pin) {
                                otp = pin;
                              },
                              onCompleted: (pin) {
                                otp = pin;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.035,
                              ),
                              child: Text(
                                GlobalVar.registerAlert,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
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
                            AnimatedContainer(
                              duration: const Duration(seconds: 2),
                              child: Container(
                                margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.035,
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  // NEW
                                  // sblmnya value param onPressed cuma panggil function sendOTP
                                  onPressed: isRun == false ? sendOTP : null,
                                  // NEW
                                  child: Text(
                                    'Resend OTP',
                                    style: GlobalFont.middlebigfontMItalic,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.04,
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.035,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors
                                        .grey, // Adjust shadow color as needed
                                    offset: Offset(
                                        2.0, 4.0), // Adjust shadow offset
                                    blurRadius:
                                        5.0, // Adjust shadow blur radius
                                    spreadRadius:
                                        1.0, // Adjust shadow spread radius
                                  ),
                                ],
                              ),
                              child: Text(
                                '${_remainingDuration}s',
                                style: GlobalFont.mediumbigfontMbutton,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GlobalVar.isLoading
                                ? const CircleLoading()
                                : Tombol(
                                    'VERIFY',
                                    verify,
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
