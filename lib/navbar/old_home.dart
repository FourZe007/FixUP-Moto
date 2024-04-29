// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:fixupmoto/widget/carousel/carousel_notifier.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/indicator/progress%20bar/circleloading.dart';
import 'package:fixupmoto/pages/home/modify_vehicle.dart';
import 'package:fixupmoto/pages/home/service_history.dart';
import 'package:fixupmoto/widget/image/customimage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:upgrader/upgrader.dart';
// Install Chiwie to display and play a video!

// ignore: must_be_immutable
class OldHome extends StatefulWidget {
  const OldHome({super.key});

  @override
  State<OldHome> createState() => _OldHomeState();
}

class _OldHomeState extends State<OldHome> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String url = '';
  List<String> homeImages = [];

  int _currentHeader = 0;
  int _currentContent = 0;

  List<ModelResultMessage> listRegistToken = [];

  List<VideoPlayerController> videoPlayerControllerList = [];
  List<ChewieController> chewieControllerList = [];
  List<dynamic> controllerList = [];
  List<dynamic> controllerListType = [];

  // Prevent blinking between Auto-Played and Non Auto-Played Carousel
  final carouselNotifier = CarouselChangeNotifier();

  List<Widget> getCarouselHeaderItems(BuildContext context) {
    return [
      for (int i = 0; i < GlobalVar.listVehicle.length; i++)
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (GlobalVar.listVehicle[i].photo == '')
                ? CustomImage(
                    image: Image.asset(
                      'assets/bike-removebg.png',
                      width: 130,
                      height: 130,
                    ),
                    isIcon: true,
                  )
                : CustomImage(
                    image: Image.memory(
                      base64Decode(GlobalVar.listVehicle[i].photo),
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    // height: MediaQuery.of(context).size.height * 0.3,
                  ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.01,
            // ),
            (GlobalVar.isChange == true)
                ? const Center(child: CircleLoading())
                : Row(
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
              height: MediaQuery.of(context).size.height * 0.01,
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

  // maybe, ga dipake. jadi mending dihapus
  List<Widget> getCarouselContentItems(BuildContext context) {
    return [
      // IMAGES
      // Column(
      //   children: [
      //     for (int i = 0; i < GlobalVar.listFilteredFeeds.length; i++)
      //       Center(
      //         child: Container(
      //           width: MediaQuery.of(context).size.width * 0.6,
      //           height: MediaQuery.of(context).size.height * 0.5,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(20.0),
      //             image: DecorationImage(
      //               image: CachedNetworkImageProvider(
      //                 GlobalVar.listFilteredFeeds[i],
      //               ),
      //               fit: BoxFit.fill,
      //             ),
      //           ),
      //         ),
      //       ),
      //   ],
      // ),

      // VIDEOS
      ListView(
        children: [
          for (int i = 0; i < GlobalVar.listFilteredFeeds.length; i++)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Chewie(
                controller: ChewieController(
                  videoPlayerController: VideoPlayerController.networkUrl(
                    Uri.parse(GlobalVar.listFilteredFeeds[i]),
                  ),
                  aspectRatio: 16 / 9,
                  autoPlay: false,
                  looping: false,
                  // Other Chewie options as needed
                ),
              ),
            ),
        ],
      ),

      // Center(
      //   child: Container(
      //     width: MediaQuery.of(context).size.width * 0.6,
      //     height: MediaQuery.of(context).size.height * 0.3,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(20.0),
      //       image: const DecorationImage(
      //         image: AssetImage('./assets/offer1.jpg'),
      //         fit: BoxFit.fill,
      //       ),
      //     ),
      //   ),
      // ),
      // Center(
      //   child: Container(
      //     width: MediaQuery.of(context).size.width * 0.6,
      //     height: MediaQuery.of(context).size.height * 0.3,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(20.0),
      //       image: const DecorationImage(
      //         image: AssetImage('./assets/offer2.jpg'),
      //         fit: BoxFit.fill,
      //       ),
      //     ),
      //   ),
      // ),
    ];
  }

  void getVehicle() async {
    GlobalVar.listVehicle = await GlobalAPI.fetchGetVehicle();
    print('Vehicle List Length: ${GlobalVar.listVehicle.length}');
    // if (GlobalVar.listVehicle.isNotEmpty) {
    //   print('Vehicle are not empty');
    // } else {
    //   print('Vehicle are empty');
    // }
  }

  void editVehicle(int mode, {int index = 0}) async {
    if (mode == 1) {
      _currentHeader = 0;
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
      _currentHeader = 0;
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

  void getInstagramData() async {
    String accessToken =
        'IGQWRQa1ZAnQ3Nuejhoel9GaDFsMVRfemxXT0wta0FHSWMtUnQzZATBDandYcjBwbkh3OS1GV0tDWGZAjeEZAkRXlxcjNFbDQtbFlmS0E1Um9pV2pqbUprN3ZAmZADd2NUNmS3llekU2SGhaYlk0UQZDZD';
    if (GlobalVar.listUserData.isNotEmpty) {
      // print('Vehicle Data');
      setState(() => GlobalVar.isLoading = true);
      GlobalVar.listVehicle = await GlobalAPI.fetchGetVehicle();
      // getVehicle();

      videoPlayerControllerList = [];
      print('Get Instagram Feeds');
      GlobalVar.listFeeds = await GlobalAPI.fetchGetFeeds(accessToken);

      for (int i = 0; i < GlobalVar.listFeeds.length; i++) {
        if (GlobalVar.listFeeds[i].mediatype == 'VIDEO' &&
            controllerList.length < 3) {
          // GlobalVar.listFilteredFeeds.add(GlobalVar.listFeeds[i].mediaurl);

          VideoPlayerController controller = VideoPlayerController.networkUrl(
              Uri.parse(GlobalVar.listFeeds[i].mediaurl));
          await controller.initialize();
          videoPlayerControllerList.add(controller);
          controllerList.add(
            ChewieController(
              videoPlayerController: controller,
              // Chewie options
            ),
          );
          controllerListType.add('video');
        } else if (GlobalVar.listFeeds[i].mediatype == 'IMAGE' &&
            controllerList.length < 3) {
          controllerList.add(GlobalVar.listFeeds[i].mediaurl.toString());
          controllerListType.add('image');
        }
      }

      GlobalVar.listFeeds = [];
      for (int i = 0; i < GlobalVar.listFilteredFeeds.length; i++) {
        print('listFilteredFeeds ${i + 1}: ${GlobalVar.listFilteredFeeds[i]}');
      }
      print(
          'videoPlayerControllerList Length: ${videoPlayerControllerList.length}');
      // print('chewieControllerList Length: ${chewieControllerList.length}');
      print('controllerList Length: ${controllerList.length}');

      // GlobalVar.listNotificationDetail =
      //     await GlobalAPI.fetchGetNotification('');

      // setState(() {});
      setState(() => GlobalVar.isLoading = false);
    } else {
      // print('GlobalVar ListUserData is empty');
    }
  }

  void getNotification() async {
    GlobalVar.listNotificationDetail = [];
    setState(() => GlobalVar.isLoading = true);
    GlobalVar.listNotificationDetail =
        await GlobalAPI.fetchGetNotification('', '0');
    // GlobalVar.notificationDetailLength = 0;
    // GlobalVar.notificationDetailLength =
    //     GlobalVar.listNotificationDetail.length;
    setState(() => GlobalVar.isLoading = false);

    // print('Home Notif Length: ${GlobalVar.notifLength}');

    // sendNotification();
  }

  // ga dipake
  // void getNotification() async {
  //   GlobalVar.listNotificationDetail = await GlobalAPI.fetchGetNotification('');
  //   setState(() {});
  // }
  //
  // ga dipake
  // void getFeeds() async {
  //   videoPlayerControllerList = [];
  //   print('Get Instagram Feeds');
  //   GlobalVar.listFeeds = await GlobalAPI.fetchGetFeeds(
  //     'IGQWRNRUZAoS043N0JPLTNscnJ5S2M5UTNSSGxodlJsWXJTVXBZALTJlVGlwem5JZAUdZAZAkZA1VjZADNEgxb19FUXZA3T2tRQU9xS3IwalpxVTFPQWtSN1c1YjdHb244TVNYWk1PVS1acFJIaXlxZAwZDZD',
  //   );
  //   for (int i = 0; i < GlobalVar.listFeeds.length; i++) {
  //     if (GlobalVar.listFeeds[i].mediatype == 'VIDEO' &&
  //         videoPlayerControllerList.length <= 3) {
  //       videoPlayerControllerList.add(
  //         VideoPlayerController.networkUrl(
  //           Uri.parse(GlobalVar.listFeeds[i].mediaurl),
  //         ),
  //       );
  //     }
  //   }
  //   GlobalVar.listFeeds = [];
  //   print('Video Player Controller: ${videoPlayerControllerList[0]}');
  //   print(
  //       'Video Player Controller Length: ${videoPlayerControllerList.length}');
  //   // videoControllers = GlobalVar.listFilteredFeeds
  //   //     .map((url) => VideoPlayerController.networkUrl(Uri.parse(url)))
  //   //     .toList();
  //   // videoControllers[0].initialize().then((_) {
  //   //   // Ensure the first frame is shown after initialization
  //   //   setState(() {});
  //   // });
  //   // for (int i = 0; i < GlobalVar.listFeeds[0].data!.length; i++) {
  //   //   // if (GlobalVar.listFeeds[0].data)
  //   //   print(GlobalVar.listFeeds[0].data![i].mediatype);
  //   // }
  //   // GlobalVar.listFeedsType = await GlobalAPI.fetchGetFeedsType(
  //   //   'IGQWRNRUZAoS043N0JPLTNscnJ5S2M5UTNSSGxodlJsWXJTVXBZALTJlVGlwem5JZAUdZAZAkZA1VjZADNEgxb19FUXZA3T2tRQU9xS3IwalpxVTFPQWtSN1c1YjdHb244TVNYWk1PVS1acFJIaXlxZAwZDZD',
  //   // );
  //   // GlobalVar.listFeedsURL = await GlobalAPI.fetchGetFeedsURL(
  //   //   'IGQWRNRUZAoS043N0JPLTNscnJ5S2M5UTNSSGxodlJsWXJTVXBZALTJlVGlwem5JZAUdZAZAkZA1VjZADNEgxb19FUXZA3T2tRQU9xS3IwalpxVTFPQWtSN1c1YjdHb244TVNYWk1PVS1acFJIaXlxZAwZDZD',
  //   // );
  //   // for (int i = 0; i < GlobalVar.listFeedsType.length; i++) {
  //   //   if (GlobalVar.listFeedsType[i].mediatype == 'IMAGE') {
  //   //     GlobalVar.listFeeds.add(GlobalVar.listFeedsURL[i].mediaurl);
  //   //   }
  //   // }
  //   // if (GlobalVar.listFeeds.isNotEmpty) {
  //   //   print('Total Data: ${GlobalVar.listFeeds.length}');
  //   //   print('Media Type: ${GlobalVar.listFeeds[0]}');
  //   // } else {
  //   //   print('Feeds Empty!');
  //   // }
  // }

  void getUserData() async {
    // setState(() => GlobalVar.isLoading = true);
    GlobalVar.listUserData = await GlobalAPI.getUserData(
      'MEMBERSHIP',
      GlobalUser.id!,
      '',
      '',
      '',
      '',
    );
    // print(GlobalVar.listUserData);

    getInstagramData();
    // setState(() => GlobalVar.isLoading = false);
  }

  void getDevice() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      GlobalUser.deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      GlobalUser.deviceName = iosInfo.name;
    } else {
      // Handle other platforms if needed
      GlobalUser.deviceName = '';
    }

    print('Device Name: ${GlobalUser.deviceName}');
  }

  Future<void> checkUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    GlobalUser.phone = prefs.getString('phonenumber');
    GlobalUser.pass = prefs.getString('password');
    GlobalUser.flag = prefs.getInt('flag');

    // GlobalVar.listSetVehicle = await GlobalAPI.fetchSetVehicle();

    print('ID: ${GlobalUser.id}');
    print('Phone: ${GlobalUser.phone}');
    print('Pass: ${GlobalUser.pass}');
    print('Flag: ${GlobalUser.flag}');

    if (GlobalUser.id == null &&
        GlobalUser.phone == null &&
        GlobalUser.pass == null &&
        GlobalUser.flag == 0) {
      Navigator.pushReplacementNamed(
        context,
        '/login',
      );
    } else {
      // getNotification();
      getDevice();

      listRegistToken = await GlobalAPI.fetchRegistDevice(
        '1',
        GlobalUser.fCMToken,
        GlobalUser.deviceName,
      );

      getUserData();
    }
  }

  @override
  void initState() {
    super.initState();

    GlobalVar.isLoading = true;

    // print('Before: ${GlobalVar.listVehicle.length}');
    checkUser(context);
    // print('After: ${GlobalVar.listVehicle.length}');
  }

  @override
  void dispose() {
    for (VideoPlayerController controller in videoPlayerControllerList) {
      controller.dispose();
    }

    // TODO: implement dispose
    super.dispose();

    GlobalVar.listVehicle = [];
    GlobalVar.listFeeds = [];
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
              backgroundColor: const Color(0xFFFE0000),
              elevation: 0.0,
              toolbarHeight: 0.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      // color: Color(0xFFF59842),
                      // color: Color(0xFF99CCFF),
                      color: Color(0xFFFE0000),
                      // border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CarouselSlider(
                          items: getCarouselHeaderItems(context),
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.425,
                            viewportFraction: 1.0,
                            autoPlay: false,
                            // onPageChanged: (index, reason) {
                            //   setState(() => _currentHeader = index);
                            // },
                            onPageChanged: (index, reason) {
                              if (reason != CarouselPageChangedReason.timed) {
                                // Don't update non-autoplay if triggered externally
                                carouselNotifier.notify(index, _currentHeader);
                                setState(() => _currentHeader = index);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        DotsIndicator(
                          dotsCount: getCarouselHeaderItems(context).length,
                          position: _currentHeader,
                          decorator: const DotsDecorator(
                            size: Size(8.0, 8.0),
                            activeSize: Size(12.0, 12.0),
                            // activeColor: Color(0xFFFFF305),
                            // activeColor: Colors.blue,
                            activeColor: Colors.black,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // 'Special Offer',
                        'Billboard',
                        style: GlobalFont.giantfontM,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.025,
                    ),
                    child: (controllerList.isNotEmpty)
                        ? Column(
                            children: [
                              CarouselSlider(
                                items: [
                                  for (int i = 0;
                                      i < controllerList.length;
                                      i++)
                                    (controllerListType[i] == 'video')
                                        ? AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Chewie(
                                              controller: controllerList[i],
                                            ),
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                  controllerList[i],
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                ],
                                options: CarouselOptions(
                                  viewportFraction: 1.0,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() => _currentContent = index);
                                  },
                                  // onPageChanged: (index, reason) {
                                  //   carouselNotifier.notify(
                                  //       index, _currentContent);
                                  //   if (reason !=
                                  //       CarouselPageChangedReason.timed) {
                                  //     // Don't update non-autoplay if triggered externally
                                  //     carouselNotifier.notify(
                                  //         index, _currentContent);
                                  //     setState(() => _currentContent = index);
                                  //   }
                                  // },
                                ),
                              ),
                              DotsIndicator(
                                dotsCount: controllerList.length,
                                position: _currentContent,
                                decorator: const DotsDecorator(
                                  size: Size(8.0, 8.0),
                                  activeSize: Size(12.0, 12.0),
                                  activeColor: Colors.red,
                                  // activeColor: Colors.blue,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
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
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
