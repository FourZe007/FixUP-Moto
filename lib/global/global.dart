import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/widget/carousel/notification_length_notifier.dart';
import 'package:flutter/material.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class GlobalUser {
  static String? id = '';
  static String? phone = '';
  static String? pass = '';
  static int? flag = 0;
  static String fCMToken = '';
  static String deviceName = "";
  static bool? isNew = false;
}

class GlobalVar {
  static bool isLoading = false;
  static bool isChange = false;

  // About Apps - String only
  // dynamic variable that will change if there's change
  static String appName = '';
  static String packageName = '';
  static String appVersion = '';
  static String buildNumber = '';
  // About Apps - Shared Preference
  static String currentAppVersion = '';

  static List<dynamic> controllerList = [];
  static List<dynamic> controllerListLink = [];
  static List<dynamic> controllerListType = [];
  static List<ModelResultMessage> listRegister = [];
  static List<ModelWorkshopDetail> listWorkshopDetail = [];
  static List<ModelBrowseUser> listUserData = [];
  static List<ModelVehicleDetail> listVehicle = [];
  static List<ModelResultMessage> listReqBook = [];
  static List<ModelServiceHistory> listServiceHistory = [];
  // static List<ModelFeedsType> listFeedsType = [];
  // static List<ModelFeedsURL> listFeedsURL = [];
  static List<ModelFeedsData> listFeeds = [];
  static List<String> listFilteredFeeds = [];
  static List<Map<String, dynamic>> listSetVehicle = [];
  static List<ModelGetVoucher> listGetVoucher = [];
  static List<ModelResultMessage> listRedeemVoucher = [];
  static List<ModelMemberInvoice> memberInvoiceList = [];
  static List<ModelMemberInvoice> memberInvoiceService = [];
  static List<ModelMemberInvoice> memberInvoiceSparePart = [];

  static List<double> latitudeList = [];
  static List<double> longitutdeList = [];

  static List<IconData> listIcons = [];

  static List<ModelNotificationDetail> listNotificationDetail = [];
  static int notificationDetailLength = 0;
  static var notifProviderLength = NotificationLengthChangeNotifier();
  // static String modifyNotificationDetail = '';
  static List listNotificationID = [];

  static late String setVehicle = '';

  static String loginAlert = '';
  static String registerAlert = '';
  static String resetOTPAlert = '';
  static String resetPasswordAlert = '';

  static int idLength = 0;
}

class GlobalFontFamily {
  static String fontCeraGR = 'CeraGR';
  static String fontCourier = 'Courier';
  static String fontRubik = 'Rubik';
  static String fontMontserrat = 'Montserrat';
}

class GlobalSize {
  static double mediumfont = 12;
  static double mediumbigfont = 14;
  static double bigfont = 16;
  static double middlegiantfont = 18;
  static double giantfont = 20;
  static double middlegigafont1 = 24;
  static double middlegigafont2 = 26;
  static double gigafont = 28;
  static double titleMenuFont1 = 32;
  static double titleMenuFont2 = 36;
}

class GlobalFont {
  // Courier
  static TextStyle mediumfontC = TextStyle(
    color: Colors.white,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.mediumbigfont,
    fontWeight: FontWeight.w600,
  );

  static TextStyle mediumfontCBlack = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.mediumbigfont,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bigfontC = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.bigfont,
    fontWeight: FontWeight.bold,
    backgroundColor: Colors.transparent,
  );

  static TextStyle bigfontCUnderlined = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.bigfont,
    fontWeight: FontWeight.bold,
    backgroundColor: Colors.transparent,
    decoration: TextDecoration.underline,
  );

  static TextStyle bigfontCWhite = TextStyle(
    color: Colors.white,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.bigfont,
    fontWeight: FontWeight.bold,
    backgroundColor: Colors.transparent,
  );

  static TextStyle middlegiantfontC = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.middlegiantfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle middlegiantfontCWhite = TextStyle(
    color: Colors.white,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.middlegiantfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle giantfontC = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.giantfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle giantfontCWhite = TextStyle(
    color: Colors.white,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.giantfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle middlegigafontC = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.middlegigafont1,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleLoginFontW2 = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontCourier,
    fontSize: GlobalSize.middlegigafont2,
    fontWeight: FontWeight.bold,
  );

  // Montserrat
  static TextStyle mediumfontM = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.mediumbigfont,
    fontWeight: FontWeight.w600,
  );

  static TextStyle mediumbigfontM = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.mediumbigfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mediumbigfontMbutton = TextStyle(
    color: Colors.red[700],
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.mediumbigfont,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

  static TextStyle middlebigfontM = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.mediumbigfont,
    backgroundColor: Colors.transparent,
  );

  static TextStyle middlebigfontMItalic = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.mediumbigfont,
    fontStyle: FontStyle.italic,
    backgroundColor: Colors.transparent,
  );

  static TextStyle bigfontM = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.bigfont,
    fontWeight: FontWeight.bold,
    backgroundColor: Colors.transparent,
  );

  static TextStyle bigfontMNormal = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.bigfont,
    backgroundColor: Colors.transparent,
  );

  static TextStyle middlegiantfontMNormal = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.middlegiantfont,
  );

  static TextStyle middlegiantfontM = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.middlegiantfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle giantfontM = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.giantfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle middlegigafontM = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.middlegigafont1,
    fontWeight: FontWeight.bold,
  );

  static TextStyle gigafontM = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontMontserrat,
    fontSize: GlobalSize.gigafont,
    fontWeight: FontWeight.bold,
  );

  // Rubik
  static TextStyle mediumfontR = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.mediumbigfont,
    fontWeight: FontWeight.w600,
  );

  static TextStyle mediumbigfontR = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.mediumbigfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mediumbigfontRNormal = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.mediumbigfont,
  );

  static TextStyle mediumBigfontRTextButton = TextStyle(
    color: Colors.blue,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.mediumbigfont,
    backgroundColor: Colors.transparent,
  );

  static TextStyle bigfontRNormal = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.bigfont,
    backgroundColor: Colors.transparent,
  );

  static TextStyle bigfontR = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.bigfont,
    fontWeight: FontWeight.bold,
    backgroundColor: Colors.transparent,
  );

  static TextStyle bigfontRUnderlinedButton = TextStyle(
    color: Colors.blue,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.bigfont,
    fontWeight: FontWeight.bold,
    backgroundColor: Colors.transparent,
    decoration: TextDecoration.underline,
  );

  static TextStyle middlegiantfontR = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.middlegiantfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle giantfontR = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.giantfont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle middlegigafontR = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.middlegigafont1,
    fontWeight: FontWeight.bold,
  );

  static TextStyle gigafontR = TextStyle(
    color: Colors.black,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.gigafont,
    fontWeight: FontWeight.bold,
  );

  static TextStyle gigafontRWhite = TextStyle(
    color: Colors.white,
    fontFamily: GlobalFontFamily.fontRubik,
    fontSize: GlobalSize.gigafont,
    fontWeight: FontWeight.bold,
  );
}

class GlobalColor {
  static Color? colorBoxMenu =
      const Color.fromARGB(136, 198, 205, 205).withOpacity(0.3);
  static Color colorCenterContainerLogin =
      const Color.fromARGB(171, 255, 255, 255);
}

class GlobalFunction {
  static tampilkanDialog(
      BuildContext context, bool isDismissible, Widget widget) {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.blue.shade50,
          elevation: 16,
          child: widget,
        );
      },
    );
  }

  // static Future<String> getAppVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   // GlobalVar.appName = packageInfo.appName;
  //   // GlobalVar.packageName = packageInfo.packageName;
  //   // GlobalVar.appVersion = packageInfo.version;
  //   // GlobalVar.buildNumber = packageInfo.buildNumber;

  //   // print('~:App Informations:~');
  //   // print('App Name: ${GlobalVar.appName}');
  //   // print('Package Name: ${GlobalVar.packageName}');
  //   // print('App Version: ${GlobalVar.appVersion}');
  //   // print('Build Number: ${GlobalVar.buildNumber}');

  //   return packageInfo.version;
  // }

  // static void changeAppVersion() async {
  //   GlobalFunction.getAppVersion().then((appVersion) {
  //     print('changeAppVersion Function - App Version: ${GlobalVar.appVersion}');

  //     if (GlobalVar.currentAppVersion == '') {
  //       GlobalVar.currentAppVersion = GlobalVar.appVersion;
  //       print(
  //           'changeAppVersion Function - Current App Version: ${GlobalVar.appVersion}');
  //     }
  //     print(
  //         'changeAppVersion Function - Current App Version: ${GlobalVar.appVersion}');
  //   });
  // }

  static void getNotification() async {
    GlobalVar.listNotificationDetail = [];
    GlobalVar.listNotificationDetail =
        await GlobalAPI.fetchGetNotification('', '0');
    GlobalVar.notificationDetailLength = 0;
    GlobalVar.notificationDetailLength =
        GlobalVar.listNotificationDetail.length;
    print('Bottom Navbar Notif Length: ${GlobalVar.notificationDetailLength}');
  }

  static void getNotificationID() {
    getNotification();
    if (GlobalVar.listNotificationID.isEmpty) {
      for (int i = 0; i < GlobalVar.listNotificationDetail.length; i++) {
        GlobalVar.listNotificationID
            .add(GlobalVar.listNotificationDetail[i].notifID);
      }
      GlobalVar.idLength = GlobalVar.listNotificationID.length;
    } else if (GlobalVar.listNotificationID.length !=
        GlobalVar.listNotificationDetail.length) {
      print('NEW DATA!!');
      for (int i = 0; i < GlobalVar.listNotificationDetail.length; i++) {
        if (GlobalVar.listNotificationID
            .contains(GlobalVar.listNotificationDetail[i].notifID)) {
          continue;
        } else {
          if (GlobalVar.listNotificationDetail[i].notifType ==
              'Service Booking Confirmed') {
            // (SHOW) send background notification to user device
            GlobalFunction.showNotification(
              GlobalVar.listNotificationDetail[i],
              GlobalVar.listNotificationDetail[i].notifType,
              'Kami tunggu kehadiran anda!!',
            );
          } else if (GlobalVar.listNotificationDetail[i].notifType ==
              'Promotion') {
            // (SHOW) send background notification to user device
            GlobalFunction.showNotification(
              GlobalVar.listNotificationDetail[i],
              GlobalVar.listNotificationDetail[i].notifType,
              'Jangan lewatkan promo yang sedang berlaku',
            );
          } else {
            // (SHOW) send background notification to user device
            GlobalFunction.showNotification(
              GlobalVar.listNotificationDetail[i],
              GlobalVar.listNotificationDetail[i].notifType,
              '',
            );
          }
          break;
        }
      }
      GlobalVar.idLength = GlobalVar.listNotificationDetail.length;
      GlobalVar.listNotificationID = GlobalVar.listNotificationDetail;
    }
  }

  static void showNotification(
    ModelNotificationDetail list,
    String title,
    String body,
  ) async {
    print('Show Notification');

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'Updates',
      'Service created',
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
      title,
      body,
      notificationDetails,
    );
  }
}
