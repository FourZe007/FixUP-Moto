import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/widget/button/date_filter_button.dart';
import 'package:fixupmoto/widget/button/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/message/message_details.dart';
import 'package:fixupmoto/widget/format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List<IconData> listIcons = [];
  List<ModelNotificationDetail> list = [];
  String returnValue = '';

  String getNotifState = '';

  String startDate = '';
  String endDate = '';
  bool unread = true;
  bool read = false;

  void setStartDate(String value) {
    startDate = value;
  }

  void setEndDate(String value) {
    endDate = value;
  }

  void setUnread() {
    setState(() {
      unread = !unread;
    });
  }

  void setRead() {
    setState(() {
      read = !read;
    });
  }

  void setIcon() {
    listIcons = [];
    for (int i = 0; i < GlobalVar.listNotificationDetail.length; i++) {
      if (GlobalVar.listNotificationDetail[i].notifType ==
          'Service Booking Confirmed') {
        listIcons.add(Icons.bookmark_added_rounded);
      } else if (GlobalVar.listNotificationDetail[i].notifType == 'Promotion') {
        listIcons.add(Icons.discount_rounded);
      } else if (GlobalVar.listNotificationDetail[i].notifType ==
          'Point Earned') {
        listIcons.add(Icons.stars_rounded);
      } else {
        listIcons.add(Icons.question_mark_rounded);
      }
    }
  }

  void sendNotification() async {
    // hrs e ini mungkin di taro di bottomnavbar aja
    // Foreground Notif
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'Updates',
      "We're waiting for you",
      channelDescription: 'Please wait the reply from us',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin.show(
      0,
      GlobalVar
          .listNotificationDetail[GlobalVar.listNotificationDetail.length - 1]
          .notifType,
      GlobalVar
          .listNotificationDetail[GlobalVar.listNotificationDetail.length - 1]
          .notif,
      notificationDetails,
    );
  }

  void loadingTrigger() {
    setState(() {
      GlobalVar.isLoading = !GlobalVar.isLoading;
    });
  }

  void getNotification() async {
    GlobalVar.listNotificationDetail = [];
    loadingTrigger();
    GlobalVar.listNotificationDetail =
        await GlobalAPI.fetchGetNotification('1', '0');
    // GlobalVar.notificationDetailLength = 0;
    // GlobalVar.notificationDetailLength =
    //     GlobalVar.listNotificationDetail.length;

    // print('Counting');
    // for (int i = 0; i < GlobalVar.listNotificationDetail.length; i++) {
    //   print('${i + 1} - ${GlobalVar.listNotificationDetail[i].notifID}');
    // }

    setIcon();
    loadingTrigger();

    // print('Message Notif Length: ${GlobalVar.notifLength}');

    // sendNotification();
  }

  void messageDetail(int index) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessageDetail(
          index,
        ),
      ),
    );

    returnValue = await GlobalAPI.fetchModifyNotification(
      '2',
      'NOTIFICATION',
      GlobalVar.listNotificationDetail[index].memberID,
      GlobalVar.listNotificationDetail[index].notifID,
      GlobalVar.listNotificationDetail[index].notifType,
      GlobalVar.listNotificationDetail[index].notif,
      GlobalVar.listNotificationDetail[index].isSent,
      '1',
    );

    if (returnValue == GlobalVar.listNotificationDetail[index].notifID) {
      print('Modify Notification: $returnValue');

      // list = await GlobalAPI.fetchGetNotification('1', '0');
      // print('New Notif Length: ${list.length}');
      // GlobalVar.listNotificationDetail = [];
      // NotificationChangeNotifier().notify(list);
      // NotificationLengthChangeNotifier().notify(list);

      getNotification();
    }
  }

  void setDate() {
    startDate = DateTime.now().toString().split(' ')[0];
    endDate = DateTime.now().toString().split(' ')[0];
    DateTime currentDate = DateFormat('yyyy-MM-dd').parse(endDate);
    DateTime futureDate = currentDate.add(const Duration(days: 30));
    endDate = DateFormat('yyyy-MM-dd').format(futureDate);
  }

  void filterMessage() async {
    print('Unread: $unread');
    print('Read: $read');

    String readState = '';
    if (unread == true && read == true) {
      readState = '';
    } else if (unread == true && read == false) {
      readState = '0';
    } else if (unread == false && read == true) {
      readState = '1';
    } else {
      readState = '';
    }

    setState(() => GlobalVar.isLoading = true);
    GlobalVar.listNotificationDetail = await GlobalAPI.fetchGetNotification(
      '',
      readState,
    );
    setIcon();

    if (GlobalVar.listNotificationDetail.isEmpty) {
      Fluttertoast.showToast(
        msg: 'No data found',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
    } else {
      print('Start Date: $startDate');
      print('End Date: $endDate');
      List<ModelNotificationDetail> tempList = [];
      print(GlobalVar.listNotificationDetail.length);

      tempList = GlobalVar.listNotificationDetail.where((notif) {
        return notif.date.compareTo(startDate) >= 0 &&
            notif.date.compareTo(endDate) <= 0;
      }).toList();

      // print('Temp List');
      // for (int i = 0; i < tempList.length; i++) {
      //   print(tempList[i]);
      // }

      GlobalVar.listNotificationDetail = [];
      GlobalVar.listNotificationDetail = tempList;
      tempList = [];
      // print('Filtered Notification Detail');
      // for (int i = 0; i < GlobalVar.listNotificationDetail.length; i++) {
      //   print(GlobalVar.listNotificationDetail[i]);
      // }
    }

    Future.delayed(const Duration(seconds: 3));
    setState(() => GlobalVar.isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    // GlobalFunction.getAppVersion();
    getNotification();
    setDate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (GlobalVar.isLoading == true) {
      return const Center(
        child: CircleLoading(warna: Colors.black),
      );
    } else {
      return DoubleTapToExit(
        snackBar: SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            'Tap again to exit',
            style: GlobalFont.bigfontR,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
        ),
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
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            title: Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.025,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Messages',
                      style: GlobalFont.middlegigafontM,
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(
                            Icons.filter_alt_rounded,
                            size: 30.0,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            leading: null,
            automaticallyImplyLeading: false,
          ),
          drawer: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: Drawer(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.025,
                          ),
                          child: DrawerHeader(
                            margin: const EdgeInsets.all(0.0),
                            padding: const EdgeInsets.all(0.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFE0000),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors
                                      .grey, // Adjust shadow color as needed
                                  offset: Offset(
                                    2.0,
                                    4.0,
                                  ), // Adjust shadow offset
                                  blurRadius: 5.0, // Adjust shadow blur radius
                                  spreadRadius:
                                      1.0, // Adjust shadow spread radius
                                ),
                              ],
                            ),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              // decoration: BoxDecoration(
                              //   border: Border.all(color: Colors.black),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Filters',
                                    style: GlobalFont.gigafontR,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.0075,
                                ),
                                child: Text(
                                  'Tanggal',
                                  style: GlobalFont.giantfontR,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.0075,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: DateFilterButton(
                                        startDate,
                                        setStartDate,
                                        false,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '-',
                                        style: GlobalFont.middlegiantfontR,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: DateFilterButton(
                                        endDate,
                                        setEndDate,
                                        false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.0075,
                                ),
                                child: Text(
                                  'Kategori',
                                  style: GlobalFont.giantfontR,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.0075,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: InkWell(
                                        onTap: setUnread,
                                        child: FilterButton(
                                          'Unread',
                                          unread,
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Expanded(
                                      flex: 5,
                                      child: InkWell(
                                        onTap: setRead,
                                        child: FilterButton(
                                          'Read',
                                          read,
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Text(''),
                        // const Text('This is Drawer'),
                      ],
                    ),
                  ),
                  // Belum ada function
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: TextButton(
                  //     onPressed: null,
                  //     child: Text(
                  //       'Reset',
                  //       style: GlobalFont.bigfontCUnderlined,
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: filterMessage,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.05,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFE0000),
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors
                                      .grey, // Adjust shadow color as needed
                                  offset:
                                      Offset(2.0, 4.0), // Adjust shadow offset
                                  blurRadius: 5.0, // Adjust shadow blur radius
                                  spreadRadius:
                                      1.0, // Adjust shadow spread radius
                                ),
                              ],
                            ),
                            child: Text(
                              'Apply',
                              style: GlobalFont.middlegiantfontR,
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
          body: (GlobalVar.isLoading == true)
              ? const Center(child: CircleLoading())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < GlobalVar.listNotificationDetail.length;
                          i++)
                        GestureDetector(
                          onTap: () => messageDetail(i),
                          child: Container(
                            margin: (i == 0)
                                ? EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                    top: MediaQuery.of(context).size.height *
                                        0.03,
                                    left: MediaQuery.of(context).size.width *
                                        0.025,
                                    right: MediaQuery.of(context).size.width *
                                        0.025,
                                  )
                                : EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                  ),
                            // margin: EdgeInsets.symmetric(
                            //   horizontal:
                            //       MediaQuery.of(context).size.width * 0.025,
                            //   vertical: MediaQuery.of(context).size.height *
                            //       0.005,
                            // ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              border: Border.all(
                                // color: const Color(0xFFF59842),
                                // color: Colors.red,
                                // color: const Color(0xFF99CCFF),
                                color: const Color(0xFFFE0000),
                                width: 3,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 75,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    // color: Colors.red,
                                    // color: Color(0xFF99CCFF),
                                    color: Color(0xFFFE0000),
                                  ),
                                  child: Icon(
                                    listIcons[i],
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Align vertically
                                      children: [
                                        Text(GlobalVar.listNotificationDetail[i]
                                            .notifType),
                                        // Add space between texts
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Text(
                                          Format.tanggalFormat(
                                            GlobalVar
                                                .listNotificationDetail[i].date,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    // color: Color(0xFFF59842),
                                    // color: Colors.red[700],
                                    // color: Color(0xFF99CCFF),
                                    color: Color(0xFFFE0000),
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
