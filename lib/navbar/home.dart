// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/bloc/instagram_feed/instagram_feed_bloc.dart';
import 'package:fixupmoto/bloc/instagram_feed/instagram_feed_event.dart';
import 'package:fixupmoto/bloc/instagram_feed/instagram_feed_state.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/pages/home/instagram_reels_viewer.dart';
import 'package:fixupmoto/widget/carousel/carousel_notifier.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart' hide CarouselController;
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/home/modify_vehicle.dart';
import 'package:fixupmoto/pages/home/service_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:upgrader/upgrader.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String url = '';
  List<String> homeImages = [];
  bool isLoading = false;

  int _currentContent = 0;

  List<ModelResultMessage> listRegistToken = [];

  List<ModelNotificationDetail> tempNotifDetail = [];
  List<ModelBrowseUser> tempBrowseUser = [];
  String deviceName = '';
  List<ModelBrowseUser> tempUserData = [];
  List<ModelVehicleDetail> tempVehicleList = [];

  final InstagramFeedBloc _instagramFeedBloc = InstagramFeedBloc();

  // Prevent blinking between Auto-Played and Non Auto-Played Carousel
  final carouselNotifier = CarouselChangeNotifier();

  void loadingTrigger() {
    setState(() {
      GlobalVar.isLoading = !GlobalVar.isLoading;
    });
  }

  List<Widget> getCarouselHeaderItems(BuildContext context) {
    return [
      for (int i = 0; i < 3; i++)
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFE0000),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.looks_one_rounded,
                size: 65.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: (GlobalVar.listVehicle[i].color == '-')
                        ? Text(
                            GlobalVar.listVehicle[i].unitID,
                            style: GlobalFont.middlegiantfontM,
                          )
                        : Text(
                            '${GlobalVar.listVehicle[i].unitID} - ${GlobalVar.listVehicle[i].color}',
                            style: GlobalFont.middlegiantfontM,
                          ),
                  ),
                  IconButton(
                    onPressed: () => editVehicle(2, index: i),
                    icon: const Icon(
                      Icons.edit,
                      size: 23.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.175,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(5.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceHistory(i),
                      ),
                    );
                    setState(() => GlobalVar.listVehicle);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.history_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      const Text(
                        'History',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      Align(
        alignment: Alignment.center,
        child: IconButton(
          iconSize: 50,
          icon: const Icon(
            Icons.add_circle_outline_rounded,
          ),
          onPressed: () => editVehicle(1),
        ),
      ),
    ];
  }

  Future<List<ModelVehicleDetail>> getVehicle() async {
    tempVehicleList.addAll(await GlobalAPI.fetchGetVehicle());

    return tempVehicleList;
  }

  void editVehicle(int mode, {int index = 0}) async {
    if (mode == 1) {
      _currentContent = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModifyVehicle(
            1,
            getVehicle,
          ),
        ),
      );
    } else if (mode == 2) {
      _currentContent = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModifyVehicle(
            2,
            getVehicle,
            index: index,
          ),
        ),
      );
    }
  }

  Future<List<ModelNotificationDetail>> getNotification() async {
    tempNotifDetail = await GlobalAPI.fetchGetNotification('', '0');

    return tempNotifDetail;
  }

  Future<List<ModelBrowseUser>> getUserData() async {
    tempUserData.addAll(await GlobalAPI.getUserData(
      'MEMBERSHIP',
      GlobalUser.id!,
      '',
      '',
      '',
      '',
    ));

    return tempUserData;
  }

  Future<String> getDevice() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
    } else {
      // Handle other platforms if needed
      deviceName = '';
    }

    return deviceName;
  }

  Future checkUser(BuildContext context) async {
    loadingTrigger();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    GlobalUser.phone = prefs.getString('phonenumber');
    GlobalUser.pass = prefs.getString('password');
    GlobalUser.flag = prefs.getInt('flag');

    if (GlobalUser.id == null &&
        GlobalUser.phone == null &&
        GlobalUser.pass == null &&
        GlobalUser.flag == 0) {
      Navigator.pushReplacementNamed(
        context,
        '/login',
      );
    } else {
      GlobalVar.listNotificationDetail = [];
      GlobalUser.deviceName = '';
      GlobalVar.listUserData = [];
      GlobalVar.listVehicle = [];

      GlobalVar.listNotificationDetail.addAll(await getNotification());
      GlobalUser.deviceName = await getDevice();

      listRegistToken = await GlobalAPI.fetchRegistDevice(
        '1',
        GlobalUser.fCMToken,
        GlobalUser.deviceName,
      );

      GlobalVar.listUserData.addAll(await getUserData());
      GlobalVar.listVehicle.addAll(await getVehicle());

      if (GlobalVar.listUserData.isNotEmpty) {
        _instagramFeedBloc.add(const InstagramFeedRequested());
      }
    }
    loadingTrigger();
  }

  @override
  void initState() {
    super.initState();

    checkUser(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _instagramFeedBloc.close();
    GlobalVar.listVehicle = [];
    tempBrowseUser = [];
    tempNotifDetail = [];
    tempUserData = [];
    tempVehicleList = [];
  }

  @override
  Widget build(BuildContext context) {
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
      child: UpgradeAlert(
        dialogStyle: UpgradeDialogStyle.cupertino,
        child: GlobalVar.isLoading == true
            ? const Center(child: CircleLoading())
            : Scaffold(
                appBar: AppBar(
                  // backgroundColor: const Color(0xFFFE0000),
                  title: Text(
                    GlobalVar.listUserData.isNotEmpty
                        ? 'Hi, ${GlobalVar.listUserData[0].memberName}'
                        : 'Hi, Bikers!',
                    style: GlobalFont.middlegiantfontR,
                  ),
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  // toolbarHeight: 0.0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(
                          "Latest Updates",
                          style: GlobalFont.giantfontR,
                        ),
                      ),
                      BlocBuilder<InstagramFeedBloc, InstagramFeedState>(
                        bloc: _instagramFeedBloc,
                        builder: (context, feedState) {
                          if (feedState.status == InstagramFeedStatus.loaded &&
                              feedState.posts.isNotEmpty) {
                            final posts = feedState.posts;

                            return Container(
                              width: MediaQuery.of(context).size.width * 0.925,
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.015,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFE0000),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  carousel_slider.CarouselSlider(
                                    items: [
                                      for (int i = 0; i < posts.length; i++)
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InstagramReelsViewer(
                                                  posts: posts,
                                                  initialIndex: i,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.0,
                                                  ),
                                                  image: DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      posts[i]
                                                              .thumbnailUrl
                                                              .isNotEmpty
                                                          ? posts[i]
                                                              .thumbnailUrl
                                                          : posts[i].mediaUrl,
                                                      maxHeight: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.35)
                                                          .round()
                                                          .toInt(),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              if (posts[i].mediaType == 'VIDEO')
                                                const Icon(
                                                  Icons.play_circle_fill,
                                                  color: Colors.white,
                                                  size: 50.0,
                                                ),
                                            ],
                                          ),
                                        ),
                                    ],
                                    options: carousel_slider.CarouselOptions(
                                      aspectRatio: 1.4,
                                      viewportFraction: 1.0,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(() => _currentContent = index);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: DotsIndicator(
                                      dotsCount: posts.length,
                                      position: _currentContent.toDouble(),
                                      decorator: const DotsDecorator(
                                        size: Size(5.0, 5.0),
                                        activeSize: Size(16.0, 5.0),
                                        spacing: EdgeInsets.symmetric(
                                          horizontal: 2.5,
                                        ),
                                        color: Colors.white,
                                        activeColor: Colors.white,
                                        shape: CircleBorder(),
                                        activeShape: StadiumBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (feedState.status == InstagramFeedStatus.loading ||
                              feedState.status == InstagramFeedStatus.initial) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: const Center(child: CircleLoading()),
                            );
                          }

                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.visibility_off_rounded,
                                  size: 40.0,
                                ),
                                Text(
                                  'Unavailable',
                                  style: GlobalFont.bigfontM,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(
                          "My Bikes",
                          style: GlobalFont.giantfontR,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.39,
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05,
                          left: MediaQuery.of(context).size.width * 0.05,
                          bottom: MediaQuery.of(context).size.height * 0.0335,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        decoration: BoxDecoration(
                          // color: Color(0xFFF59842),
                          // color: Color(0xFF99CCFF),
                          // color: const Color(0xFFFE0000),
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int i = 0;
                                  i < GlobalVar.listVehicle.length;
                                  i++)
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ServiceHistory(i),
                                      ),
                                    );
                                    setState(() => GlobalVar.listVehicle);
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minHeight:
                                          MediaQuery.of(context).size.height *
                                              0.115,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.025,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFE0000),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 50,
                                            height: 45,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Text(
                                              '${i + 1}',
                                              style: GlobalFont.gigafontRWhite,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.025,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    (GlobalVar.listVehicle[i]
                                                                .color ==
                                                            '-')
                                                        ? Expanded(
                                                            flex: 4,
                                                            child: Text(
                                                              'FIXUP MOTO',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GlobalFont
                                                                  .middlegiantfontM,
                                                            ),
                                                          )
                                                        : Expanded(
                                                            flex: 4,
                                                            child: Text(
                                                              GlobalVar
                                                                  .listVehicle[
                                                                      i]
                                                                  .unitID,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GlobalFont
                                                                  .middlegiantfontM,
                                                            ),
                                                          ),
                                                    Expanded(
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            editVehicle(2,
                                                                index: i),
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          size: 23.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: (GlobalVar
                                                              .listVehicle[i]
                                                              .color ==
                                                          '-')
                                                      ? Text(
                                                          GlobalVar
                                                              .listVehicle[i]
                                                              .plateNumber,
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          style: GlobalFont
                                                              .middlegiantfontM,
                                                        )
                                                      : Text(
                                                          '${GlobalVar.listVehicle[i].color} - ${GlobalVar.listVehicle[i].plateNumber}',
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          style: GlobalFont
                                                              .middlegiantfontM,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Icon(
                                            Icons.arrow_right_rounded,
                                            size: 60.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              InkWell(
                                onTap: () => editVehicle(1),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.115,
                                  margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFE0000),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.add_circle_outline_rounded,
                                        size: 50,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Add your bike',
                                          style: GlobalFont.middlegiantfontM,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_right_rounded,
                                        size: 60.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                            ],
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
