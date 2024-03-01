// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/label_title_static.dart';
import 'package:fixupmoto/widget/textfield.dart/customxuserinput.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String newPass = '';
  String newConfirmationPass = '';
  List<ModelResultMessage> list = [];
  List<ModelUser> listLogin = [];
  bool isSame = false;
  String phoneNumber = '';

  void setNewPass(String value) {
    newPass = value;
  }

  void setNewConfimationPass(String value) {
    newConfirmationPass = value;
  }

  void getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString('phonenumber')!;
  }

  void reset() async {
    if (newPass == newConfirmationPass) {
      isSame = false;
    } else {
      isSame = true;
    }

    if (isSame == false) {
      setState(() => GlobalVar.isLoading = true);
      listLogin = await GlobalAPI.loginAccount(phoneNumber, '00000');

      list = await GlobalAPI.modifyAccount(
        '5',
        listLogin[0].memberID,
        '',
        newPass,
        '',
        '',
        '',
      );
      setState(() => GlobalVar.isLoading = true);
      if (list[0].resultMessage == listLogin[0].memberID) {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'SUCCESS!',
            message: 'Password berhasil diubah',

            /// change contentType to ContentType.success,
            /// ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        Navigator.pushReplacementNamed(context, '/init');
      } else {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'FAILED!',
            message: 'Password gagal diubah',

            /// change contentType to ContentType.success,
            /// ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'FAILED!',
          message: 'Password tidak sama',

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

  @override
  void initState() {
    getPhoneNumber();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
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
          child: Wrap(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                ),
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      './assets/reset.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black),
                // ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LabelTitleStatic(
                          "Reset Password",
                          GlobalFont.titleLoginFontW2,
                        ),
                      ],
                    ),
                    const Text(
                      'Please enter your new password',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomUserInput(
                          setNewPass,
                          newPass,
                          mode: 0,
                          isPass: true,
                          hint: 'password baru',
                          isIcon: true,
                          icon: Icons.lock,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomUserInput(
                          setNewConfimationPass,
                          newConfirmationPass,
                          mode: 0,
                          isPass: true,
                          hint: 'kembali password baru',
                          isIcon: true,
                          icon: Icons.lock,
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
                            left: MediaQuery.of(context).size.width * 0.035,
                          ),
                          child: Text(
                            GlobalVar.resetPasswordAlert,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlobalVar.isLoading
                        ? const CircleLoading()
                        : Tombol(
                            'RESET',
                            reset,
                            lebar: MediaQuery.of(context).size.width * 0.9,
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
