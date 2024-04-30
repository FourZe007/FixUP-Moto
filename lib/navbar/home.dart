// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/widget/carousel/carousel_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/home/modify_vehicle.dart';
import 'package:fixupmoto/pages/home/service_history.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:upgrader/upgrader.dart';
// Install Chiwie to display and play a video!

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

  List<VideoPlayerController> videoPlayerControllerList = [];
  List<ChewieController> chewieControllerList = [];
  List<dynamic> tempControllerList = [];
  List<dynamic> tempControllerListType = [];

  List<ModelNotificationDetail> tempNotifDetail = [];
  List<ModelBrowseUser> tempBrowseUser = [];
  String deviceName = '';
  List<ModelBrowseUser> tempUserData = [];
  List<ModelVehicleDetail> tempVehicleList = [];

  String longLivedAccessToken =
      'IGQWRNUS1scEw2azNvclFBVUVvQ0dpVUkzdnRnbTFKQlZAweXBLMDA5N2NBYjQzczJwYkJVMklxZADZArQmkxSEFCS2pvbUZAlcTI5WlVxc2Y0WV9wVE15RHI5LXlOZATl3QURVSjhzUU9jaHBUZAwZDZD';
  ModelAccessToken accessTokenModel =
      ModelAccessToken(accessToken: '', bearer: '', duration: 0);

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

  Future<List<dynamic>> getInstagramData() async {
    if (GlobalVar.listUserData.isNotEmpty) {
      videoPlayerControllerList = [];
      print('Get Instagram Feeds');
      GlobalVar.listFeeds = [];

      if (DateTime.now().day == 28) {
        accessTokenModel =
            await GlobalAPI.fetchGetNewAccessToken(longLivedAccessToken);

        longLivedAccessToken = accessTokenModel.accessToken;
      }

      GlobalVar.listFeeds
          .addAll(await GlobalAPI.fetchGetFeeds(longLivedAccessToken));
      videoPlayerControllerList = [];
      tempControllerList = [];
      tempControllerListType = [];

      for (int i = 0; i < GlobalVar.listFeeds.length; i++) {
        if (GlobalVar.listFeeds[i].mediatype == 'VIDEO' &&
            tempControllerList.length < 3) {
          VideoPlayerController controller = VideoPlayerController.networkUrl(
              Uri.parse(GlobalVar.listFeeds[i].mediaurl));
          await controller.initialize();
          videoPlayerControllerList.add(controller);
          tempControllerList.add(
            ChewieController(
              videoPlayerController: controller,
              // Chewie options
            ),
          );
          tempControllerListType.add('video');
        } else if (GlobalVar.listFeeds[i].mediatype == 'IMAGE' &&
            tempControllerList.length < 3) {
          tempControllerList.add(GlobalVar.listFeeds[i].mediaurl.toString());
          tempControllerListType.add('image');
        }
      }

      return [tempControllerList, tempControllerListType];
    } else {
      return [];
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
      GlobalVar.controllerList = [];
      GlobalVar.controllerListLink = [];
      GlobalVar.controllerListType = [];

      GlobalVar.listNotificationDetail.addAll(await getNotification());
      GlobalUser.deviceName = await getDevice();

      listRegistToken = await GlobalAPI.fetchRegistDevice(
        '1',
        GlobalUser.fCMToken,
        GlobalUser.deviceName,
      );

      GlobalVar.listUserData.addAll(await getUserData());
      GlobalVar.listVehicle.addAll(await getVehicle());
      GlobalVar.controllerList.addAll(await getInstagramData());
      GlobalVar.controllerListLink.addAll(GlobalVar.controllerList[0]);
      GlobalVar.controllerListType.addAll(GlobalVar.controllerList[1]);
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

    GlobalVar.listVehicle = [];
    GlobalVar.listFeeds = [];
    tempBrowseUser = [];
    tempControllerList = [];
    tempControllerListType = [];
    tempNotifDetail = [];
    tempUserData = [];
    tempVehicleList = [];
  }

  @override
  Widget build(BuildContext context) {
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
        child: GlobalVar.isLoading == true
            ? const Center(child: CircleLoading())
            : Scaffold(
                appBar: AppBar(
                  // backgroundColor: const Color(0xFFFE0000),
                  title: Text(
                    GlobalVar.listUserData.isNotEmpty
                        ? 'Welcome, ${GlobalVar.listUserData[0].memberName}'
                        : 'Welcome, Bikers!',
                    style: GlobalFont.middlegigafontR,
                  ),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (GlobalVar.controllerListLink.isNotEmpty)
                          ? InkWell(
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                    'https://www.instagram.com/fixupmotoidn_official/',
                                  ),
                                );
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width:
                                    MediaQuery.of(context).size.width * 0.925,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.015,
                                  vertical: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFE0000),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 12,
                                      child: CarouselSlider(
                                        items: [
                                          for (int i = 0;
                                              i <
                                                  GlobalVar.controllerListLink
                                                      .length;
                                              i++)
                                            (GlobalVar.controllerListType[i] ==
                                                    'video')
                                                ? Chewie(
                                                    controller: GlobalVar
                                                        .controllerListLink[i],
                                                  )
                                                : Container(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                          GlobalVar
                                                              .controllerListLink[i],
                                                          maxHeight: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.35)
                                                              .round()
                                                              .toInt(),
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                        ],
                                        options: CarouselOptions(
                                          aspectRatio: 1,
                                          viewportFraction: 1.0,
                                          autoPlay: true,
                                          onPageChanged: (index, reason) {
                                            setState(
                                                () => _currentContent = index);
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: DotsIndicator(
                                        dotsCount:
                                            GlobalVar.controllerListLink.length,
                                        position: _currentContent,
                                        decorator: const DotsDecorator(
                                          size: Size(8.0, 8.0),
                                          activeSize: Size(12.0, 12.0),
                                          activeColor: Colors.black,
                                          // activeColor: Colors.blue,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
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
                          "Bikes",
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
                                                          style: GlobalFont
                                                              .middlegiantfontM,
                                                        )
                                                      : Text(
                                                          '${GlobalVar.listVehicle[i].color} - ${GlobalVar.listVehicle[i].plateNumber}',
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
