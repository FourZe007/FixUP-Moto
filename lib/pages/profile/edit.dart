// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/widget/button/button.dart';
import 'package:fixupmoto/widget/textfield.dart/customxuserinput.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = '';
  String id = '';
  String email = '';
  String number = '';
  List<ModelResultMessage> list = [];

  void setName(String value) {
    print('name before: $name');
    name = value;
    print('name after: $name');
  }

  void setID(String value) {
    print('id before: $id');
    id = value;
    print('id after: $id');
  }

  void setEmail(String value) {
    print('email before: $email');
    email = value;
    print('email after: $email');
  }

  void setNumber(String value) {
    print('number before: $number');
    number = value;
    print('number after: $number');
  }

  void setUserProfile() {
    setState(() => GlobalVar.isLoading = true);
    setName(GlobalVar.listUserData[0].memberName);
    setID(GlobalVar.listUserData[0].memberID);
    setEmail(GlobalVar.listUserData[0].email);
    setNumber(GlobalVar.listUserData[0].phoneNumber);
    setState(() => GlobalVar.isLoading = false);
  }

  void saveProfile() async {
    if (name == GlobalVar.listUserData[0].memberName &&
        email == GlobalVar.listUserData[0].email) {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'FAILED!',
          message: 'Ubah nama dan/atau email anda untuk update profile',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      list = await GlobalAPI.modifyAccount(
        '2',
        GlobalVar.listUserData[0].memberID,
        name,
        '',
        GlobalVar.listUserData[0].phoneNumber,
        email,
        '',
      );

      if (list[0].resultMessage == GlobalVar.listUserData[0].memberID) {
        GlobalVar.listUserData = await GlobalAPI.getUserData(
          'MEMBERSHIP',
          GlobalUser.id!,
          '',
        );
        // jaga-jaga biar data yang barusan diupdate sudah bener-bener terupdate
        // di dalam aplikasi
        // setState(() {});

        list = [];
        Navigator.pop(context, true);

        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'SUCCESS!',
            message: 'Data anda berhasil diupdate',

            /// change contentType to ContentType.success,
            /// ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,
          ),
        );

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
            message: list[0].resultMessage,

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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setUserProfile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (GlobalVar.isLoading == true) {
      return const Center(child: CircleLoading());
    } else {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
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
                    'Nomor Telepon',
                    style: GlobalFont.bigfontR,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: CustomUserInput(
                    setNumber,
                    number,
                    isDataAvailable: true,
                    hint: 'nomor telepon',
                    isIcon: true,
                    icon: Icons.phone,
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
                    'Nama',
                    style: GlobalFont.bigfontR,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: CustomUserInput(
                    setName,
                    name,
                    isCapital: true,
                    isDataAvailable: true,
                    mode: 0,
                    hint: 'nama',
                    isIcon: true,
                    icon: Icons.person,
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
                    'ID',
                    style: GlobalFont.bigfontR,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: CustomUserInput(
                    setID,
                    id,
                    isDataAvailable: true,
                    hint: 'id',
                    isIcon: true,
                    icon: Icons.info_rounded,
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
                    'Email',
                    style: GlobalFont.bigfontR,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005,
                  ),
                  child: CustomUserInput(
                    setEmail,
                    email,
                    isDataAvailable: true,
                    mode: 0,
                    hint: 'email',
                    isIcon: true,
                    icon: Icons.mail_rounded,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
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
                      'SAVE',
                      saveProfile,
                      lebar: MediaQuery.of(context).size.width,
                      // ga pengaruh, karena param disable di command
                      disable: (name != GlobalVar.listUserData[0].memberName ||
                              email != GlobalVar.listUserData[0].email)
                          ? false
                          : true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
