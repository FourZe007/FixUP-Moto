// ignore_for_file: use_build_context_synchronously
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/widget/button/filter_button.dart';
import 'package:fixupmoto/widget/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class VoucherHistory extends StatefulWidget {
  VoucherHistory(this.validVoucher, {super.key});

  int validVoucher;

  @override
  State<VoucherHistory> createState() => _VoucherHistoryState();
}

class _VoucherHistoryState extends State<VoucherHistory>
    with TickerProviderStateMixin {
  // late AnimationController _controller;
  // late AnimationController _panelController;
  // late Animation<double> _opacityAnimation;
  bool isQRPop = false;

  String svg = '';

  bool isGenerate = false;
  bool isSlidingUpWidgetOpen = false;
  bool isLoading = false;
  bool isRun = false;

  String voucherID = '';
  var image;

  bool isPanelOpen = false;
  double minHeight = 50.0;

  bool isAll = false;
  bool isValid = true;
  bool isInvalid = false;
  List<int> filterOptions = [];

  List<ModelBrowseUserDetail2> invoiceDetail = [];

  // late final PictureInfo pictureInfo;

  void getVoucher() async {
    GlobalVar.listGetVoucher = await GlobalAPI.fetchGetVoucher('POINTID');
  }

  void getData() {
    invoiceDetail = [];
    for (int i = 0; i < GlobalVar.listUserData[0].detail2.length; i++) {
      invoiceDetail.add(GlobalVar.listUserData[0].detail2[i]);
    }
  }

  void filter() {
    // print('Filter Options: ${filterOptions[0]}');
    if (filterOptions.length < 2 && filterOptions.isNotEmpty) {
      print('~:IN:~');
      // Invalid
      if (filterOptions[0] == 0) {
        invoiceDetail = [];
        for (int i = 0; i < GlobalVar.listUserData[0].detail2.length; i++) {
          if (GlobalVar.listUserData[0].detail2[i].voucherState == 0) {
            invoiceDetail.add(GlobalVar.listUserData[0].detail2[i]);
          }
        }
      }
      // Valid
      else if (filterOptions[0] == 1) {
        invoiceDetail = [];
        for (int i = 0; i < GlobalVar.listUserData[0].detail2.length; i++) {
          if (GlobalVar.listUserData[0].detail2[i].voucherState == 1) {
            invoiceDetail.add(GlobalVar.listUserData[0].detail2[i]);
          }
        }
      }
    } else {
      getData();
    }
    setState(() => invoiceDetail);
    print(invoiceDetail);
    // for (int i = 0; i < invoiceDetail.length; i++) {
    //   for (int j = 0; j < filterOptions.length - 1; j++) {
    //     if (filterOptions[j] == 0 && filterOptions[j + 1] == 1) {
    //       invoiceDetail = [];
    //     } else if (filterOptions[j] == 0) {
    //     } else if (filterOptions[j] == 1) {
    //     } else {
    //       getData();
    //       break;
    //     }
    //   }
    // }
  }

  void validButtonPressed() {
    print('isValid Before: $isValid');
    // print('filterOptions Before: $filterOptions');
    setState(() {
      isValid = !isValid;
      //filterOptions
    });
    print('isValid After: $isValid');

    print('filterOptions Before: $filterOptions');
    if (isValid == true) {
      filterOptions.add(1);
    } else {
      filterOptions.remove(1);
    }
    setState(() => filterOptions);
    print('filterOptions After: $filterOptions');

    filter();
  }

  void invalidButtonPressed() {
    print('isInvalid Before: $isInvalid');
    // print('filterOptions Before: $filterOptions');
    setState(() {
      isInvalid = !isInvalid;
      //filterOptions
    });
    print('isInvalid After: $isInvalid');

    print('filterOptions Before: $filterOptions');
    if (isInvalid == true) {
      filterOptions.add(0);
    } else {
      filterOptions.remove(0);
    }
    setState(() => filterOptions);
    print('filterOptions After: $filterOptions');

    filter();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    setState(() => GlobalVar.isLoading = true);
    getData();
    setState(() => GlobalVar.isLoading = false);
  }

  @override
  void dispose() {
    svg = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (GlobalVar.isLoading == true) {
      return const Center(child: CircleLoading());
    } else {
      return WillPopScope(
        onWillPop: () async {
          // Prevent the default back button behavior
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Vouchers',
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
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025,
                  ),
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.025,
                    right: MediaQuery.of(context).size.width * 0.025,
                    top: MediaQuery.of(context).size.height * 0.0125,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.filter_alt_rounded,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              'Filters',
                              style: GlobalFont.giantfontR,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      GestureDetector(
                        onTap: validButtonPressed,
                        child: FilterButton(
                          'Valid',
                          isValid,
                          MediaQuery.of(context).size.width * 0.175,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      GestureDetector(
                        onTap: invalidButtonPressed,
                        child: FilterButton(
                          'Invalid',
                          isInvalid,
                          MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0125,
                ),
                for (int i = 0; i < invoiceDetail.length; i++)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.195,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.0125,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.025,
                      vertical: MediaQuery.of(context).size.height * 0.025,
                    ),
                    decoration: BoxDecoration(
                      color: (invoiceDetail[i].voucherState == 0)
                          ? Colors.grey[350]
                          : Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          // color: Color(0xFFF59842),
                          // color: Color(0xFF99CCFF),
                          color: Color(0xFFFE0000),
                          offset: Offset(0.0, 0.0), //Offset
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(
                        // color: const Color(0xFFF59842),
                        // color: const Color(0xFF99CCFF),
                        color: const Color(0xFFFE0000),
                        width: 3,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 14,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // Align vertically
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  invoiceDetail[i].voucherName,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Add space between texts
                              const SizedBox(height: 5.0),
                              Expanded(
                                child: Text(
                                  invoiceDetail[i].voucherNumber,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text('Redeem Date: '),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      Format.tanggalFormat(
                                        invoiceDetail[i].redeemDate,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5.0),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text('Expired Date: '),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        Format.tanggalFormat(
                                          invoiceDetail[i].expiredDate,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            onPressed: () {
                              if (invoiceDetail[i].voucherState == 0) {
                                null;
                              } else {
                                GlobalFunction.tampilkanDialog(
                                  context,
                                  true,
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: AlertDialog(
                                      title: Text(
                                        invoiceDetail[i].voucherNumber,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: QrImageView(
                                        data: invoiceDetail[i].voucherNumber,
                                        version: QrVersions.auto,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.5,
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
                              }
                            },
                            icon: const Icon(
                              Icons.qr_code_rounded,
                              size: 35,
                            ),
                          ),
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
