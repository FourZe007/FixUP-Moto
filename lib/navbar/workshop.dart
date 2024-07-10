import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/widget/popupdialog/kotakpesan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/dealer/workshop_details.dart';
import 'package:flutter/widgets.dart';

class Workshop extends StatefulWidget {
  const Workshop({super.key});

  @override
  State<Workshop> createState() => _WorkshopState();
}

class _WorkshopState extends State<Workshop> {
  // void loadingTrigger() {
  //   setState(() {
  //     GlobalVar.isLoading = !GlobalVar.isLoading;
  //   });
  // }

  Future<List<ModelWorkshopDetail>> getWorkshops() async {
    GlobalVar.listWorkshopDetail.clear();
    GlobalVar.listWorkshopDetail = await GlobalAPI.fetchGetWorkshop(
      'BRANCHSHOP',
    );
    // GlobalVar.latitudeList = [-7.330453856628143, -7.263224495143975];
    // GlobalVar.longitutdeList = [112.74886179025017, 112.68171265415458];

    return GlobalVar.listWorkshopDetail;
  }

  void workshopDetails(int index, bool status) {
    if (status == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkshopDetails(
            index,
          ),
        ),
      );
    } else {
      GlobalFunction.tampilkanDialog(
        context,
        false,
        KotakPesan(
          'WARNING!',
          'Coming Soon',
          tinggi: MediaQuery.of(context).size.height * 0.175,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // GlobalFunction.getAppVersion();
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
        // showIgnore: false,
        //   showLater: false,
        //   dialogStyle: UpgradeDialogStyle.cupertino,
        // ~:UpgradeAlert removed, only available in Login and Home page:~
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
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            title: Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.025,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Our Locations',
                    style: GlobalFont.middlegigafontM,
                  ),
                ],
              ),
            ),
            leading: null,
            automaticallyImplyLeading: false,
          ),
          body: FutureBuilder(
            future: getWorkshops(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircleLoading());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Failed to load data'),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.015,
                          ),
                          child: Column(
                            children:
                                snapshot.data!.asMap().entries.map((entry) {
                              final int index = entry.key;
                              final ModelWorkshopDetail workshop = entry.value;

                              return InkWell(
                                onTap: () => workshopDetails(
                                  index,
                                  workshop.isOpen,
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.1325,
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.025,
                                    right: MediaQuery.of(context).size.width *
                                        0.025,
                                    top: MediaQuery.of(context).size.width *
                                        0.0125,
                                    bottom: MediaQuery.of(context).size.width *
                                        0.0125,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (workshop.isOpen == true)
                                        ? Colors.transparent
                                        : Colors.grey[350],
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
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0125,
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          // color: Color(0xFFF59842),
                                          // color: Color(0xFF99CCFF),
                                          color: Color(0xFFFE0000),
                                        ),
                                        child: Image(
                                          image: const AssetImage(
                                            './assets/dealer-default-2.png',
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.225,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                workshop.name,
                                                style: const TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                workshop.address,
                                                style: const TextStyle(
                                                  fontSize: 12.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Color(0xFFFE0000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      );
    }
  }
}
