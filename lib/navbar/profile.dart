import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:clipboard/clipboard.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/pages/profile/edit.dart';
import 'package:fixupmoto/pages/profile/service_invoice.dart';
import 'package:fixupmoto/pages/profile/settings.dart';
import 'package:fixupmoto/pages/profile/sparepart_invoice.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:upgrader/upgrader.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  bool returnResult = false;

  List<ModelResultMessage> listDeleteToken = [];

  // void logout() async {
  //   GlobalUser.id = '';
  //   GlobalUser.phone = '';
  //   GlobalUser.pass = '';
  //   GlobalUser.flag = 0;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   print('Device Token: ${GlobalUser.fCMToken}');
  //   print('Device Name: ${GlobalUser.deviceName}');
  //   listDeleteToken = await GlobalAPI.fetchRegistDevice(
  //     '2',
  //     GlobalUser.fCMToken,
  //     GlobalUser.deviceName,
  //   );
  //   // ignore: use_build_context_synchronously
  //   Navigator.pushReplacementNamed(context, '/login');
  // }

  void getMemberInvoice() async {
    setState(() => isLoading = true);
    GlobalVar.memberInvoiceList =
        await GlobalAPI.fetchGetMemberInvoice('', '', '');
    setState(() => isLoading = false);

    GlobalVar.memberInvoiceService = [];
    GlobalVar.memberInvoiceSparePart = [];
    for (int i = 0; i < GlobalVar.memberInvoiceList.length; i++) {
      if (GlobalVar.memberInvoiceList[i].jenis == 'SERVICE') {
        GlobalVar.memberInvoiceService.add(GlobalVar.memberInvoiceList[i]);
      } else if (GlobalVar.memberInvoiceList[i].jenis == 'SPAREPART') {
        GlobalVar.memberInvoiceSparePart.add(GlobalVar.memberInvoiceList[i]);
      }
    }
  }

  void navigateToEditPage() async {
    returnResult = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfile(),
      ),
    );

    if (returnResult == true) {
      setState(() => GlobalVar.isLoading = true);
      GlobalVar.listUserData = await GlobalAPI.getUserData(
        'MEMBERSHIP',
        GlobalUser.id!,
        '',
        '',
        '',
        '',
      );
      setState(() => GlobalVar.isLoading = false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // GlobalFunction.getAppVersion();
    getMemberInvoice();
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
        child: UpgradeAlert(
          dialogStyle: UpgradeDialogStyle.cupertino,
          child: Scaffold(
            appBar: AppBar(
              // backgroundColor: const Color(0xFFF59842),
              // backgroundColor: Colors.red,
              backgroundColor: const Color(0xFFFE0000),
              elevation: 0.0,
              // toolbarHeight: 0.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              toolbarHeight: MediaQuery.of(context).size.height * 0.225,
              title: Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.025,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.225,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0225,
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.025,
                                ),
                                child: Text(
                                  'Welcome,',
                                  style: GlobalFont.middlegigafontM,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                                child: Text(
                                  GlobalVar.listUserData.isNotEmpty
                                      ? GlobalVar.listUserData[0].memberName
                                      : '',
                                  style: GlobalFont.gigafontM,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                      child: Text(
                                        GlobalVar.listUserData.isNotEmpty
                                            ? GlobalVar.listUserData[0].memberID
                                            : '',
                                        style: GlobalFont.middlegiantfontM,
                                      ),
                                    ),
                                    GlobalVar.listUserData.isNotEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              FlutterClipboard.copy(GlobalVar
                                                  .listUserData[0].memberID);
                                            },
                                            child: const Icon(
                                              Icons.copy,
                                              size: 20.0,
                                              weight: 0.5,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: navigateToEditPage,
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileSettings(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.settings),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: null,
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.025,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                            ),
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.height * 0.02,
                              0.0,
                              MediaQuery.of(context).size.height * 0.005,
                              0.0,
                            ),
                            child: Text(
                              'Profile',
                              style: GlobalFont.bigfontR,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                            ),
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.height * 0.02,
                              0.0,
                              MediaQuery.of(context).size.height * 0.005,
                              0.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.mail_rounded, size: 30.0),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: GlobalFont.bigfontR,
                                    ),
                                    Text(
                                      GlobalVar.listUserData[0].email != ''
                                          ? GlobalVar.listUserData[0].email
                                          : '-',
                                      style: GlobalFont.giantfontR,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                            ),
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.height * 0.02,
                              0.0,
                              MediaQuery.of(context).size.height * 0.005,
                              0.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.phone, size: 30.0),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nomor Telepon',
                                      style: GlobalFont.bigfontR,
                                    ),
                                    Text(
                                      GlobalVar.listUserData.isNotEmpty
                                          ? '0${GlobalVar.listUserData[0].phoneNumber}'
                                          : '',
                                      style: GlobalFont.giantfontR,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                            ),
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.height * 0.02,
                              0.0,
                              MediaQuery.of(context).size.height * 0.005,
                              0.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.pedal_bike_rounded,
                                  size: 30.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Kendaraan',
                                      style: GlobalFont.bigfontR,
                                    ),
                                    Text(
                                      GlobalVar.listUserData.isNotEmpty
                                          ? GlobalVar.listUserData[0].qty
                                              .toString()
                                          : '',
                                      style: GlobalFont.giantfontR,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.025,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                            ),
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.height * 0.02,
                              0.0,
                              MediaQuery.of(context).size.height * 0.005,
                              0.0,
                            ),
                            child: Text(
                              'Invoice',
                              style: GlobalFont.bigfontR,
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ServiceInvoice(),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.height * 0.025,
                                0.0,
                                MediaQuery.of(context).size.height * 0.005,
                                0.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.handyman_rounded,
                                    size: 30.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Service',
                                          style: GlobalFont.giantfontR,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.001,
                                        ),
                                        Text(
                                          'Tap to view',
                                          style: GlobalFont.mediumbigfontR,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    // color: Color(0xFFF59842),
                                    // color: Colors.red[700],
                                    // color: Colors.blue,
                                    color: Color(0xFFFE0000),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SparepartInvoice(),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.height * 0.025,
                                0.0,
                                MediaQuery.of(context).size.height * 0.005,
                                0.0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.precision_manufacturing_rounded,
                                    size: 30.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Spare Parts',
                                          style: GlobalFont.giantfontR,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.001,
                                        ),
                                        Text(
                                          'Tap to view',
                                          style: GlobalFont.mediumbigfontR,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    // color: Color(0xFFF59842),
                                    // color: Colors.red[700],
                                    // color: Colors.blue,
                                    color: Color(0xFFFE0000),
                                  ),
                                ],
                              ),
                            ),
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
}
