import 'dart:async';
import 'dart:math';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_title_static.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

// ignore: must_be_immutable
class ResetVerification extends StatefulWidget {
  ResetVerification(this.phoneNumber, {super.key});

  String phoneNumber;

  @override
  State<ResetVerification> createState() => _ResetVerificationState();
}

class _ResetVerificationState extends State<ResetVerification> {
  int randomNumber = 0;
  int _remainingDuration = 60;
  Timer? _timer;
  ModelSendOTP mapSendOTP = ModelSendOTP(resultMessage: '');
  bool isVerified = false;
  bool isRun = false;
  String otp = '';
  String number = '';

  void setNumber(String value) {
    number = value;
  }

  void setRandomNumber() {
    // Generate a random number between 1,000 and 9,999
    randomNumber = Random().nextInt(9000) + 1000;

    // Prints the random number, for example: 5,912
    print('Random Number: $randomNumber');
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
            GlobalVar.resetOTPAlert = "OTP Code expired";
            setState(() => isRun = false);
            print('Countdown completed');
          }
        }
      },
    );
  }

  void sendOTP() async {
    if (widget.phoneNumber != '') {
      setRandomNumber();
      // give warning if the phone format was wrong
      // NEW
      String message =
          '[FIXUP MOTO] ${randomNumber.toString()} adalah kode registrasi Anda. Demi Keamanan, jangan bagikan kode ini. Kode ini kadaluarsa dalam 1 menit.';
      mapSendOTP = await GlobalAPI.fetchSendOTP(
        '62${widget.phoneNumber}',
        message,
        'poco-phone',
        // 'realme-tab',
        'text',
      );

      print('Send OTP result: ${mapSendOTP.resultMessage}');

      if (mapSendOTP.resultMessage == 'pending') {
        setState(() {
          GlobalVar.resetOTPAlert = "Kode OTP berhasil dikirim";
        });

        _remainingDuration = 60;
        _startTimer();
        // if (isExpired == false) {
        //   setState(() {
        //     GlobalVar.resetOTPAlert = "Kode OTP berhasil dikirim";
        //   });

        //   _remainingDuration = 60;
        //   _startTimer();
        // } else {
        //   setState(() {
        //     GlobalVar.resetOTPAlert =
        //         "Mohon tunggu $_remainingDuration detik untuk kirim kode OTP";
        //   });
        // }
      } else {
        setState(() {
          GlobalVar.resetOTPAlert = "Kode OTP gagal dikirim";
        });
      }
    } else {
      setState(() {
        GlobalVar.resetOTPAlert = "Periksa kembali input anda";
      });
    }
  }

  void verify() {
    if (randomNumber.toString() == otp) {
      Fluttertoast.showToast(
        msg: 'OTP VERIFIED, please wait for a moment.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      isVerified = true;
      setState(() {
        GlobalVar.resetOTPAlert = "OTP is verified";
      });

      Navigator.pushReplacementNamed(context, '/reset');
    } else {
      isVerified = false;
      setState(() {
        GlobalVar.resetOTPAlert = "Invalid OTP";
      });
    }
    setState(() => isVerified);
  }

  @override
  void initState() {
    GlobalVar.resetOTPAlert = '';
    setRandomNumber();
    sendOTP();

    // TODO: implement initState
    super.initState();
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: const Color(0xFFF59842),
          // backgroundColor: Colors.red,
          // backgroundColor: const Color(0xFF99CCFF),
          backgroundColor: const Color(0xFFFE0000),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            //replace with our own icon data.
          ),
        ),
        body: SingleChildScrollView(
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
                        Expanded(
                          child: LabelTitleStatic(
                            "Let's verify your identity first",
                            GlobalFont.titleLoginFontW2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04,
                          ),
                          child: const Text(
                            'Please enter your Whatsapp verification code',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
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
                            GlobalVar.resetOTPAlert,
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
                              left: MediaQuery.of(context).size.width * 0.035,
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
                                offset:
                                    Offset(2.0, 4.0), // Adjust shadow offset
                                blurRadius: 5.0, // Adjust shadow blur radius
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
                                lebar: MediaQuery.of(context).size.width * 0.9,
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
    );
  }
}
