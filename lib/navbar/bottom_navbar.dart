import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/widget/carousel/notification_length_notifier.dart';
// import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/navbar/workshop.dart';
import 'package:fixupmoto/navbar/home.dart';
import 'package:fixupmoto/navbar/member.dart';
import 'package:fixupmoto/navbar/messages.dart';
import 'package:fixupmoto/navbar/profile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  bool isLoading = false;
  int currentPageIndex = 0;
  int messageLength = 0;

  // List<ModelNotificationDetail> listMessageDetail = [];
  List<ModelNotificationDetail> notifDetailTemp = [];
  List<ModelNotificationDetail> list = [];

  // Customize Bottom Navbar
  final autoSizeGroup = AutoSizeGroup();

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.home,
    Icons.message,
    Icons.location_on_rounded,
    Icons.person_pin_rounded,
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Messages(),
    Workshop(),
    Profile(),
    Member(),
  ];

  void _onItemTapped(int index) {
    if (GlobalVar.isLoading == false) {
      setState(() {
        currentPageIndex = index;
      });
    } else {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Please wait a moment',
          message: '',

          /// change contentType to ContentType.success,
          /// ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  // Future<void> getNotification() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   GlobalUser.id = prefs.getString('id');
  //
  //   notifDetailTemp = [];
  //   setState(() => GlobalVar.isLoading = true);
  //   notifDetailTemp = await GlobalAPI.fetchGetNotification('1', '0');
  //   // NotificationChangeNotifier().notify(notifDetailTemp);
  //   GlobalVar.notificationDetailLength = 0;
  //   GlobalVar.notificationDetailLength = notifDetailTemp.length;
  //   print('Notification Detail Length: ${GlobalVar.notificationDetailLength}');
  //
  //   // setState(() {});
  //   setState(() => GlobalVar.isLoading = false);
  //
  //   // print('Counting');
  //   // for (int i = 0; i < GlobalVar.listNotificationDetail.length; i++) {
  //   //   print('${i + 1} - ${GlobalVar.listNotificationDetail[i].notifID}');
  //   // }
  //   // print('Bottom Navbar Notif Length: ${GlobalVar.notificationDetailLength}');
  //   // sendNotification();
  // }

  Stream<int> getNotification() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GlobalUser.id = prefs.getString('id');

    notifDetailTemp = [];
    notifDetailTemp = await GlobalAPI.fetchGetNotification('1', '0');
    print('StreamBuilder getNotification length: ${notifDetailTemp.length}');
    yield notifDetailTemp.length;
  }

  // void getUpdatedNotification() async {
  //   // list = await GlobalAPI.fetchGetNotification('1', '0');
  //   // print('New Notif Length: ${list.length}');
  //   // GlobalVar.listNotificationDetail = [];
  //   // NotificationChangeNotifier().notify(list);
  //   // return GlobalVar.listNotificationDetail.length;
  // }
  //
  // void getNotification() async {
  //   GlobalVar.listNotificationDetail = [];
  //   // setState(() => GlobalVar.isLoading = true);
  //   GlobalVar.listNotificationDetail = await GlobalAPI.fetchGetNotification('');
  //   // setState(() => GlobalVar.isLoading = false);
  //   print('Notif Length: ${GlobalVar.listNotificationDetail.length}');
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setState(() => GlobalVar.isLoading = true);
    getNotification();
    // setState(() => GlobalVar.isLoading = false);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // updateData();
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () => getNotification(),
    // );

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    GlobalVar.notifProviderLength =
        Provider.of<NotificationLengthChangeNotifier>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // backgroundColor: const Color(0xFFF59842),
        // backgroundColor: const Color(0xFF99CCFF),
        shape: const StadiumBorder(),
        backgroundColor: const Color(0xFFFE0000),
        child: Icon(
          Icons.contact_emergency_rounded,
          color: (currentPageIndex == _widgetOptions.length - 1)
              ? Colors.white
              : Colors.black,
        ),
        onPressed: () {
          _fabAnimationController.reset();
          _borderRadiusAnimationController.reset();
          _borderRadiusAnimationController.forward();
          _fabAnimationController.forward();

          _onItemTapped(_widgetOptions.length - 1);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        // backgroundColor: const Color(0xFF99CCFF),
        backgroundColor: const Color(0xFFFE0000),
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          // return Icon(
          //   iconList[index],
          //   size: 24,
          //   // color: isActive ? const Color(0xFFF59842) : Colors.black,
          //   // color: isActive ? Colors.blue[800] : Colors.black,
          //   color: isActive ? Colors.white : Colors.black,
          // );
          // getUpdatedNotification();
          if (iconList[index] == Icons.message) {
            // Icons with number at the top right
            // return FutureBuilder(
            //   future: getNotification(),
            //   builder: (context, snapshot) {
            //     return AnimatedContainer(
            //       duration: const Duration(seconds: 1),
            //       alignment: Alignment.center,
            //       child: Stack(
            //         children: <Widget>[
            //           Positioned(
            //             left: MediaQuery.of(context).size.width * 0.074,
            //             top: MediaQuery.of(context).size.height * 0.01885,
            //             child: Icon(
            //               iconList[index],
            //               size: 24,
            //               color: isActive ? Colors.white : Colors.black,
            //             ),
            //           ),
            //           Positioned(
            //             left: MediaQuery.of(context).size.width * 0.0325,
            //             // left: MediaQuery.of(context).size.width * 0.115,
            //             top: MediaQuery.of(context).size.height * 0.009,
            //             child: Center(
            //               child: Container(
            //                 height: MediaQuery.of(context).size.height * 0.025,
            //                 // width: MediaQuery.of(context).size.width * 0.05,
            //                 padding: EdgeInsets.symmetric(
            //                   horizontal:
            //                       MediaQuery.of(context).size.width * 0.015,
            //                   vertical:
            //                       MediaQuery.of(context).size.height * 0.0025,
            //                 ),
            //                 decoration: BoxDecoration(
            //                   color: Colors.yellow,
            //                   // border: Border.all(color: Colors.yellow),
            //                   borderRadius: BorderRadius.circular(20.0),
            //                 ),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Text(
            //                       GlobalVar.notificationDetailLength.toString(),
            //                       style: GlobalFont.mediumbigfontRNormal,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // );
            return AnimatedContainer(
              duration: const Duration(seconds: 1),
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.074,
                    top: MediaQuery.of(context).size.height * 0.01885,
                    child: Icon(
                      iconList[index],
                      size: 24,
                      color: isActive ? Colors.white : Colors.black,
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.0425,
                    // left: MediaQuery.of(context).size.width * 0.115,
                    top: MediaQuery.of(context).size.height * 0.009,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.0225,
                      // width: MediaQuery.of(context).size.width * 0.05,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.015,
                        vertical: MediaQuery.of(context).size.height * 0.0025,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        // border: Border.all(color: Colors.yellow),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder(
                            stream: getNotification(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                  style: GlobalFont.mediumbigfontRNormal,
                                );
                              }
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                                child: const Text(''),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Icon(
              iconList[index],
              size: 24,
              // color: isActive ? const Color(0xFFF59842) : Colors.black,
              // color: isActive ? Colors.blue[800] : Colors.black,
              color: isActive ? Colors.white : Colors.black,
            );
          }
        },
        activeIndex: currentPageIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: _onItemTapped,
        //other params
      ),
      body: DoubleTapToExit(
        snackBar: SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Warning',
            message: 'Tap again to exit',
            contentType: ContentType.warning,
          ),
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            // statusBarColor: Color(0xFFF59842),
            // statusBarColor: Color(0xFF99CCFF),
            statusBarColor: Color(0xFFFE0000),
          ),
          sized: false,
          child: _widgetOptions.elementAt(currentPageIndex),
        ),
      ),
    );
  }
}
