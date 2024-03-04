import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/dealer/workshop_details.dart';

class Workshop extends StatefulWidget {
  const Workshop({super.key});

  @override
  State<Workshop> createState() => _WorkshopState();
}

class _WorkshopState extends State<Workshop> {
  void getWorkshops() async {
    setState(() => GlobalVar.isLoading = true);
    GlobalVar.listWorkshopDetail = await GlobalAPI.fetchGetWorkshop(
      'BRANCHSHOP',
    );
    GlobalVar.latitudeList = [-7.330453856628143, -7.263224495143975];
    GlobalVar.longitutdeList = [112.74886179025017, 112.68171265415458];
    setState(() => GlobalVar.isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getWorkshops();
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
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: (GlobalVar.listWorkshopDetail.isNotEmpty)
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            for (int i = 0;
                                i < GlobalVar.listWorkshopDetail.length;
                                i++)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkshopDetails(
                                        GlobalVar.listWorkshopDetail[i].name,
                                        GlobalVar.listWorkshopDetail[i].address,
                                        GlobalVar
                                            .listWorkshopDetail[i].operation,
                                        GlobalVar.listWorkshopDetail[i].phone,
                                        i,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
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
                                        height: 75,
                                        width: 100,
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        decoration: const BoxDecoration(
                                          // color: Color(0xFFF59842),
                                          // color: Color(0xFF99CCFF),
                                          color: Color(0xFFFE0000),
                                        ),
                                        child: const Image(
                                          image: AssetImage(
                                            './assets/dealer-default.png',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // Align vertically
                                          children: [
                                            Text(
                                              GlobalVar
                                                  .listWorkshopDetail[i].name,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // Add space between texts
                                            const SizedBox(height: 5.0),
                                            Text(
                                              GlobalVar.listWorkshopDetail[i]
                                                  .address,
                                              style: const TextStyle(
                                                  fontSize: 12.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        // color: Color(0xFFF59842),
                                        // color: Color(0xFF99CCFF),
                                        color: Color(0xFFFE0000),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Location Unavailable',
                                style: GlobalFont.bigfontMNormal,
                              ),
                              Text(
                                'Hubungi Admin FixUP Moto untuk info lebih lanjut',
                                style: GlobalFont.middlebigfontM,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
