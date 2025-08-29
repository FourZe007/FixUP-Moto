import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class UserTextFieldSuffix extends StatefulWidget {
  UserTextFieldSuffix(this.hint, this.email, this.myauth, this.userInput,
      {super.key});

  String hint;
  String email;
  EmailOTP myauth;
  TextEditingController userInput;

  @override
  State<UserTextFieldSuffix> createState() => _UserTextFieldSuffixState();
}

class _UserTextFieldSuffixState extends State<UserTextFieldSuffix> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Masukkan ${widget.hint} anda',
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
          suffixIcon: TextButton(
            onPressed: () async {
              log('pressed');
              widget.myauth.setConfig(
                appEmail: "josephangelus.jobs@gmail.com",
                appName: "Email OTP",
                userEmail: widget.email,
                otpLength: 4,
                otpType: OTPType.digitsOnly,
              );

              if (await widget.myauth.sendOTP() == true) {
                Fluttertoast.showToast(
                  msg: 'OTP has been sent',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              } else {
                Fluttertoast.showToast(
                  msg: 'OTP send failed',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              }
            },
            child: const Text(
              'Send OTP',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        controller: widget.userInput,
      ),
    );
  }
}
