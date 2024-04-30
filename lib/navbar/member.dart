import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/member/points_history.dart';
import 'package:fixupmoto/pages/member/voucher_history.dart';
import 'package:fixupmoto/widget/dropdown/popupvisibility.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:upgrader/upgrader.dart';

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  int validVoucher = 0;

  void loadingTrigger() {
    setState(() {
      GlobalVar.isLoading = !GlobalVar.isLoading;
    });
  }

  void getVoucher() async {
    loadingTrigger();
    GlobalVar.listGetVoucher = await GlobalAPI.fetchGetVoucher('POINTID');

    int validVoucher = 0;

    for (int i = 0; i < GlobalVar.listUserData[0].detail2.length; i++) {
      if (GlobalVar.listUserData[0].detail2[i].voucherMemoState == 'VALID') {
        validVoucher += 1;
      }
    }
    print('Valid Voucher: $validVoucher');
    loadingTrigger();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // GlobalFunction.getAppVersion();
    getVoucher();
  }

  @override
  Widget build(BuildContext context) {
    if (GlobalVar.isLoading == true) {
      return const Center(
        child: CircleLoading(),
      );
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              // toolbarHeight: 0.0,
              toolbarHeight: MediaQuery.of(context).size.height * 0.275,
              title: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * 0.05,
                ),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.1,
                decoration: const BoxDecoration(
                  // color: Color(0xFFF59842),
                  // color: Colors.red[600],
                  // color: Color(0xFF99CCFF),
                  // color: Color(0xFFFE0000),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    GlobalFunction.tampilkanDialog(
                      context,
                      true,
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: AlertDialog(
                          title: Text(
                            GlobalVar.listUserData[0].memberID,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: QrImageView(
                            data: GlobalVar.listUserData[0].memberID,
                            version: QrVersions.auto,
                            size: MediaQuery.of(context).size.width * 0.5,
                            gapless: false,
                            errorStateBuilder: (cxt, err) {
                              return const Center(
                                child: Text(
                                  'Uh oh! Something went wrong...',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // Adjust width as needed
                    width: double.infinity,
                    // Adjust height as needed
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('./assets/card.jpg'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.065,
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Wrap(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.qr_code,
                                size: 30.0,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Text(
                                GlobalVar.listUserData[0].memberID,
                                style: GlobalFont.middlegigafontM,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              leading: null,
              automaticallyImplyLeading: false,
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.035,
                              ),
                              child: Text(
                                'Informations',
                                style: GlobalFont.giantfontR,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PointsHistory(),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02,
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
                                  Icons.stars_rounded,
                                  size: 30.0,
                                  // color: Color(0xFFF59842),
                                  // color: Color(0xFF99CCFF),
                                  color: Color(0xFFFE0000),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Total Points',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                      ),
                                      Text(
                                        '${GlobalVar.listUserData[0].points} points',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
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
                        Divider(
                          height: MediaQuery.of(context).size.height * 0.001,
                          thickness: 1.5,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.grey[200]!,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VoucherHistory(validVoucher),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02,
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
                                  Icons.discount_rounded,
                                  size: 30.0,
                                  // color: Color(0xFFF59842),
                                  // color: Color(0xFF99CCFF),
                                  color: Color(0xFFFE0000),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Redeemed Vouchers',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                      ),
                                      Text(
                                        '${GlobalVar.listUserData[0].detail2.length}',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.035,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Text(
                                'Redeem Voucher',
                                style: GlobalFont.giantfontR,
                              ),
                            ),
                          ],
                        ),
                        GlobalVar.listGetVoucher.isNotEmpty
                            ? Column(
                                children: [
                                  for (int i = 0;
                                      i < GlobalVar.listGetVoucher.length;
                                      i++)
                                    PopUpVisibility(
                                      GlobalVar.listGetVoucher[i],
                                    )
                                ],
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Voucher Unavailable',
                                      style: GlobalFont.bigfontMNormal,
                                    ),
                                    Text(
                                      'Hubungi Admin FixUP Moto untuk info lebih lanjut',
                                      style: GlobalFont.middlebigfontM,
                                    ),
                                  ],
                                ),
                              ),
                      ],
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
