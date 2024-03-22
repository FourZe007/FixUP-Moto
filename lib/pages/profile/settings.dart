import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/pages/profile/change.dart';
import 'package:fixupmoto/pages/profile/edit.dart';
import 'package:fixupmoto/widget/button/action_button.dart';
import 'package:fixupmoto/widget/popupdialog/kotakpesan.dart';
import 'package:fixupmoto/widget/popupdialog/kotakpesan_2button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  List<ModelResultMessage> listDeleteToken = [];
  List<ModelResultMessage> listModifyAccount = [];
  bool isSame = false;
  String newPass = '';
  String oldPass = '';
  String confirmPass = '';

  void setNewPass(String value) {
    newPass = value;
  }

  void setOldPass(String value) {
    oldPass = value;
  }

  void setConfirmPass(String value) {
    confirmPass = value;
  }

  // void change() async {
  //   listModifyAccount = [];
  //   if (newPass == confirmPass && oldPass == GlobalUser.pass) {
  //     listModifyAccount = await GlobalAPI.modifyAccount(
  //       '3',
  //       GlobalUser.id!,
  //       '',
  //       newPass,
  //       '',
  //       '',
  //       oldPass,
  //     );
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //     // ignore: use_build_context_synchronously
  //     GlobalFunction.tampilkanDialog(
  //       context,
  //       true,
  //       const KotakPesan(
  //         'SUCCESS',
  //         'Password berhasil diubah',
  //       ),
  //     );
  //   } else {
  //     GlobalFunction.tampilkanDialog(
  //       context,
  //       true,
  //       const KotakPesan(
  //         'WARNING',
  //         'Periksa input anda kembali',
  //       ),
  //     );
  //   }
  // }

  // void changeConfirmation() {
  //   print('Pressed!');
  //   GlobalFunction.tampilkanDialog(
  //     context,
  //     false,
  //     KotakPesanChangePass(
  //       'GANTI PASSWORD',
  //       'WARNING',
  //       // Old Password
  //       CustomUserInput(
  //         setOldPass,
  //         oldPass,
  //         isPass: true,
  //         hint: 'password lama',
  //         icon: Icons.lock,
  //         autoFocus: true,
  //       ),
  //       // New Password
  //       CustomUserInput(
  //         setNewPass,
  //         newPass,
  //         isPass: true,
  //         hint: 'password baru',
  //         icon: Icons.lock,
  //         autoFocus: true,
  //       ),
  //       // Confirm Password
  //       CustomUserInput(
  //         setConfirmPass,
  //         confirmPass,
  //         isPass: true,
  //         hint: 'password konfirmasi',
  //         icon: Icons.lock,
  //         autoFocus: true,
  //       ),
  //       change,
  //       buttonWidth1: MediaQuery.of(context).size.width * 0.15,
  //       buttonHeight1: MediaQuery.of(context).size.height * 0.04,
  //       buttonWidth2: MediaQuery.of(context).size.width * 0.2,
  //       buttonHeight2: MediaQuery.of(context).size.height * 0.04,
  //       sizedBoxHeight: MediaQuery.of(context).size.height * 0.4,
  //       sizedBoxWidth: MediaQuery.of(context).size.width * 0.85,
  //     ),
  //   );
  // }

  void changePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePassword(),
      ),
    );
  }

  void submit() {
    Navigator.pop(context);
  }

  // void delete() async {
  //   listModifyAccount = [];
  //   listModifyAccount = await GlobalAPI.modifyAccount(
  //     '4',
  //     GlobalUser.id!,
  //     '',
  //     '',
  //     '',
  //     '',
  //     '',
  //   );
  //   if (listModifyAccount[0].resultMessage == GlobalUser.id) {
  //     // ignore: use_build_context_synchronously
  //     GlobalFunction.tampilkanDialog(
  //       context,
  //       false,
  //       Text(
  //         'Akun berhasil dihapus',
  //         style: GlobalFont.middlegiantfontM,
  //       ),
  //     );
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     GlobalFunction.tampilkanDialog(
  //       context,
  //       false,
  //       Text(
  //         'Akun gagal dihapus',
  //         style: GlobalFont.middlegiantfontM,
  //       ),
  //     );
  //   }
  //   Navigator.pop(context);
  // }

  void delete() async {
    listModifyAccount = [];
    listModifyAccount = await GlobalAPI.modifyAccount(
      '4',
      GlobalUser.id!,
      '',
      '',
      '',
      '',
      '',
    );

    if (listModifyAccount[0].resultMessage == GlobalUser.id) {
      // ignore: use_build_context_synchronously
      GlobalFunction.tampilkanDialog(
        context,
        false,
        Text(
          'Akun berhasil dihapus',
          style: GlobalFont.middlegiantfontM,
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      GlobalFunction.tampilkanDialog(
        context,
        false,
        Text(
          'Akun gagal dihapus',
          style: GlobalFont.middlegiantfontM,
        ),
      );
    }

    Navigator.pop(context);

    // LAUNCH URL
    // Uri url =
    //     Uri.parse('http://saptaajimp.com/fixupmoto/?data=${GlobalUser.phone}');
    // String url = 'http://saptaajimp.com/fixupmoto?data=${GlobalUser.phone}';
    // String url = 'http://203.201.175.80/fixupmotodelete/#/account';
    // print('Uri URL: $url');
    // if (!await canLaunchUrl(Uri.parse(url))) {
    //   // throw 'Could not launch $url';
    //   // ignore: use_build_context_synchronously
    //   GlobalFunction.tampilkanDialog(
    //     context,
    //     true,
    //     const KotakPesan(
    //       'WARNING',
    //       'Invalid URL',
    //     ),
    //   );
    // } else {
    //   await launchUrl(Uri.parse(url));
    // }
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   // Handle URL launch error
    //   // ignore: use_build_context_synchronously
    //   GlobalFunction.tampilkanDialog(
    //     context,
    //     true,
    //     const KotakPesan(
    //       'WARNING',
    //       'Invalid URL',
    //     ),
    //   );
    // }
  }

  void deleteConfirmation() {
    print('Pressed!');
    GlobalFunction.tampilkanDialog(
      context,
      false,
      KotakPesan2Button(
        'WARNING',
        'HAPUS AKUN INI?',
        delete,
        buttonWidth1: MediaQuery.of(context).size.width * 0.15,
        buttonHeight1: MediaQuery.of(context).size.height * 0.04,
        buttonWidth2: MediaQuery.of(context).size.width * 0.2,
        buttonHeight2: MediaQuery.of(context).size.height * 0.04,
      ),
    );
  }

  void editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfile(),
      ),
    );
  }

  void launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Handle URL launch error
      // ignore: use_build_context_synchronously
      GlobalFunction.tampilkanDialog(
        context,
        true,
        const KotakPesan(
          'WARNING',
          'Invalid URL',
        ),
      );
    }
  }

  void logout() async {
    listDeleteToken = await GlobalAPI.fetchRegistDevice(
      '2',
      GlobalUser.fCMToken,
      GlobalUser.deviceName,
    );

    GlobalUser.id = '';
    GlobalUser.phone = '';
    GlobalUser.pass = '';
    GlobalUser.flag = 0;
    GlobalUser.isNew = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    print('Device Token: ${GlobalUser.fCMToken}');
    print('Device Name: ${GlobalUser.deviceName}');

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/init');
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent the default back button behavior
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: GlobalFont.giantfontM,
          ),
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
            children: [
              ActionButton(
                'Edit Profile',
                editProfile,
              ),
              Divider(
                height: MediaQuery.of(context).size.height * 0.001,
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
                color: Colors.grey[200]!,
              ),
              ActionButton(
                'Change Password',
                changePassword,
              ),
              Divider(
                height: MediaQuery.of(context).size.height * 0.001,
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
                color: Colors.grey[200]!,
              ),
              ActionButton(
                'Delete Account',
                deleteConfirmation,
              ),
              // GestureDetector(
              //   behavior: HitTestBehavior.translucent,
              //   onTap: () {
              //     delete();
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(
              //       top: MediaQuery.of(context).size.width * 0.035,
              //       bottom: MediaQuery.of(context).size.width * 0.035,
              //     ),
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: MediaQuery.of(context).size.height * 0.04,
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: MediaQuery.of(context).size.width * 0.4,
              //           child: const Text(
              //             'Delete Account',
              //             style: TextStyle(
              //               fontSize: 20.0,
              //               color: Colors.black,
              //             ),
              //           ),
              //         ),
              //         Container(
              //           width: MediaQuery.of(context).size.width * 0.5,
              //           alignment: Alignment.centerRight,
              //           child: const Icon(
              //             Icons.arrow_forward_ios_rounded,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Divider(
                height: MediaQuery.of(context).size.height * 0.001,
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
                color: Colors.grey[200]!,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                      // color: Color(0xFFF59842),
                      // color: Color(0xFF99CCFF),
                      color: Color(0xFFFE0000),
                      width: 2.5,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    shadowColor: const Color(0xFFF59842),
                  ),
                  onPressed: logout,
                  child: Text(
                    'Log Out',
                    style: GlobalFont.middlegiantfontM,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.475,
              ),
              Text(
                'Follow Our Social Media',
                style: GlobalFont.bigfontM,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.0075,
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              'https://www.instagram.com/fixupmotoidn_official/',
                            ),
                          );
                        },
                        child: Image(
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: MediaQuery.of(context).size.height * 0.05,
                          image: const AssetImage(
                            './assets/ig.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              'https://www.facebook.com/profile.php?id=100092857964956&mibextid=ZbWKwL',
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.facebook_rounded,
                          size: 35.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              'http://saptaajimp.com/fixupmoto',
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.link_rounded,
                          size: 35.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Version 1.0.4',
                style: GlobalFont.middlebigfontM,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
