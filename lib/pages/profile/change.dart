import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/textfield.dart/customxuserinput.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String newPass = '';
  String oldPass = '';
  String confirmPass = '';
  List<ModelResultMessage> listModifyAccount = [];

  void setNewPass(String value) {
    newPass = value;
  }

  void setOldPass(String value) {
    oldPass = value;
  }

  void setConfirmPass(String value) {
    confirmPass = value;
  }

  void changePassword() async {
    listModifyAccount = [];
    if (newPass == confirmPass && oldPass == GlobalUser.pass) {
      listModifyAccount = await GlobalAPI.modifyAccount(
        '3',
        GlobalUser.id!,
        '',
        newPass,
        '',
        '',
        oldPass,
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
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

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'WARNING!',
          message: 'Periksa input anda kembali',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Change Password',
              style: GlobalFont.giantfontM,
            ),
            // backgroundColor: const Color(0xFFF59842),
            // backgroundColor: Colors.red,
            // backgroundColor: const Color(0xFF99CCFF),
            backgroundColor: const Color(0xFFFE0000),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, false);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.045,
                    right: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Text(
                    'Old Password',
                    style: GlobalFont.bigfontR,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: CustomUserInput(
                    setOldPass,
                    oldPass,
                    isPass: true,
                    hint: 'password lama',
                    icon: Icons.lock,
                    autoFocus: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.045,
                    right: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.015,
                    bottom: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Text(
                    'New Password',
                    style: GlobalFont.bigfontR,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  // New Password
                  child: CustomUserInput(
                    setNewPass,
                    newPass,
                    isPass: true,
                    hint: 'password baru',
                    icon: Icons.lock,
                    autoFocus: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.045,
                    right: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.015,
                    bottom: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: Text(
                    'Re-enter New Password',
                    style: GlobalFont.bigfontR,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  // Confirm Password
                  child: CustomUserInput(
                    setConfirmPass,
                    confirmPass,
                    isPass: true,
                    hint: 'password konfirmasi',
                    icon: Icons.lock,
                    autoFocus: true,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.46,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.0175,
                  ),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black),
                  // ),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                      vertical: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Tombol(
                      'CHANGE',
                      changePassword,
                      lebar: MediaQuery.of(context).size.width,
                      // ga pengaruh, karena param disable di command
                      disable:
                          (oldPass != '' && newPass != '' && confirmPass != '')
                              ? false
                              : true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
