// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';

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
              print('pressed');
              widget.myauth.setConfig(
                appEmail: "josephangelus.jobs@gmail.com",
                appName: "Email OTP",
                userEmail: widget.email,
                otpLength: 4,
                otpType: OTPType.digitsOnly,
              );
              final snackBar;
              if (await widget.myauth.sendOTP() == true) {
                snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Success!',
                    message: 'OTP has been sent',

                    /// change contentType to ContentType.success,
                    /// ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Oops',
                    message: 'OTP send failed',

                    /// change contentType to ContentType.success,
                    /// ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
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
