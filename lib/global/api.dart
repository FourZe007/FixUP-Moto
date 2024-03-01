import 'dart:convert';
import 'dart:developer';

import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:http/http.dart' as http;

class GlobalAPI {
  static Future<List<ModelResultMessage>> modifyAccount(
    String mode,
    String memberID,
    String memberName,
    String memberPass,
    String phoneNo,
    String emailAddress,
    String oldPass,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Modify');

    Map mapRegister = {
      "Mode": mode,
      "TransID": "REGISTRATION",
      'Data': {
        "MemberID": memberID,
        "MemberName": memberName,
        "MemberPass": memberPass,
        "PhoneNo": phoneNo,
        "EmailAddress": emailAddress,
        "OldPass": oldPass,
      }
    };

    print('mapRegister');
    print(mapRegister);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapRegister), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      print(response.body);
      List<ModelResultMessage> list = [];

      if (response.statusCode <= 200) {
        var jsonGetLogin = jsonDecode(response.body);
        if (jsonGetLogin['Code'] == '100' || jsonGetLogin['Msg'] == 'Sukses') {
          List<ModelResultMessage> list = (jsonGetLogin['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelResultMessage> list = (jsonGetLogin['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelUser>> loginAccount(
    String phoneNumber,
    String pass,
  ) async {
    var url = Uri.https(
        'wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Master/LoginMembership');

    Map mapLogin = {
      "PhoneNo": phoneNumber,
      "DecryptedPassword": pass,
    };

    print('mapLogin');
    print(mapLogin);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapLogin), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      print(response.body);
      List<ModelUser> list = [];

      if (response.statusCode <= 200) {
        var jsonGetLogin = jsonDecode(response.body);
        if (jsonGetLogin['Code'] == '100' || jsonGetLogin['Msg'] == 'Sukses') {
          List<ModelUser> list = (jsonGetLogin['Data'] as List)
              .map<ModelUser>((data) => ModelUser.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelUser> list = (jsonGetLogin['Data'] as List)
              .map<ModelUser>((data) => ModelUser.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelBrowseUser>> getUserData(
    String type,
    String memberID,
    String status,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/BrowseTrans');

    Map mapUserData = {
      "Jenis": type,
      "MemberID": memberID,
      "Status": status,
    };

    print('mapUserData');
    print(mapUserData);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapUserData), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      print(response.body);
      List<ModelBrowseUser> list = [];

      if (response.statusCode <= 200) {
        var jsonGetLogin = jsonDecode(response.body);
        if (jsonGetLogin['Code'] == '100' || jsonGetLogin['Msg'] == 'Sukses') {
          List<ModelBrowseUser> list = (jsonGetLogin['Data'] as List)
              .map<ModelBrowseUser>((data) => ModelBrowseUser.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelBrowseUser> list = (jsonGetLogin['Data'] as List)
              .map<ModelBrowseUser>((data) => ModelBrowseUser.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<ModelSendOTP> fetchSendOTP(
    String phoneNumber,
    String message,
    String deviceId,
    String messageType,
  ) async {
    var url = Uri.https('haryanto-agus-api.kirimwa.id', '/v1/messages');

    Map mapOTP = {
      "phone_number": phoneNumber,
      "message": message,
      "device_id": deviceId,
      "message_type": messageType,
    };

    print('mapOTP');
    print(mapOTP);

    ModelSendOTP mapSendOTP = ModelSendOTP(resultMessage: '');

    try {
      final response = await http.post(url, body: jsonEncode(mapOTP), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        // 'Authorization':
        //     'Bearer g3jIZaoJY0Rw7L9fc4zJlSjdkjNPnFJ6Pw1ofCMJhhvy3rg42VJn7h8JW1FCXN+t-haryanto',
        'Authorization':
            'Bearer Tb_3yl}VYq78qB^/NVWy0OXqgwPj0rTMhrU50qfG^@58~Hbt-enterprise',
      }).timeout(const Duration(seconds: 60));

      print(response.body);

      if (response.statusCode <= 201) {
        var jsonSendOTP = jsonDecode(response.body);
        if (jsonSendOTP['status'] == 'pending' ||
            jsonSendOTP['message'] ==
                'Message is pending and waiting to be processed.') {
          mapSendOTP = ModelSendOTP(resultMessage: jsonSendOTP['status']);

          print(mapSendOTP.resultMessage);
          return mapSendOTP;
        } else {
          mapSendOTP = ModelSendOTP(resultMessage: jsonSendOTP['status']);

          print(mapSendOTP.resultMessage);
          return mapSendOTP;
        }
      }

      return mapSendOTP;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelResultMessage>> fetchModifyVehicle(
    String mode,
    String transID,
    String memberID,
    String plateNumber,
    String unitID,
    String chasisNumber,
    String engineNumber,
    String color,
    String year,
    String photo,
    int? line,
  ) async {
    // userid = checkUser(context) as String;
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Modify');

    print('API Data');
    print('Member ID: $memberID');
    print('Plate Number: $plateNumber');
    print('Unit ID: $unitID');
    print('Chasis Number: $chasisNumber');
    print('Engine Number: $engineNumber');
    print('Color: $color');
    print('Year: $year');
    print('Photo: $photo');
    // print('Line: $line');

    Map mapModifyVehicle = {};
    if (mode == '1') {
      mapModifyVehicle = {
        "Mode": mode,
        "TransID": transID,
        'Data': {
          "MemberID": memberID,
          "PlateNo": plateNumber,
          "UnitID": unitID,
          "ChasisNo": chasisNumber,
          "EngineNo": engineNumber,
          "Color": color,
          "Year": year,
          "Photo": photo,
        }
      };
    } else if (mode == '2') {
      mapModifyVehicle = {
        "Mode": mode,
        "TransID": transID,
        'Data': {
          "MemberID": memberID,
          "PlateNo": plateNumber,
          "UnitID": unitID,
          "ChasisNo": chasisNumber,
          "EngineNo": engineNumber,
          "Color": color,
          "Year": year,
          "Photo": photo,
          "Line": line,
        }
      };
    }

    print('mapModifyVehicle');
    print(mapModifyVehicle);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapModifyVehicle), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      List<ModelResultMessage> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetAsset = jsonDecode(response.body);
        if (jsonGetAsset['Code'] == '100' && jsonGetAsset['Msg'] == 'Sukses') {
          List<ModelResultMessage> list = (jsonGetAsset['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelResultMessage> list = (jsonGetAsset['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelVehicleDetail>> fetchGetVehicle() async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/BrowseTrans');

    Map mapGetVehicle = {
      "Jenis": "MEMBERSHIPMOTOR",
      "MemberID": GlobalUser.id,
    };

    print('mapGetVehicle');
    print(mapGetVehicle);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapGetVehicle), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      List<ModelVehicleDetail> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetAsset = jsonDecode(response.body);
        if (jsonGetAsset['Code'] == '100' && jsonGetAsset['Msg'] == 'Sukses') {
          List<ModelVehicleDetail> list = (jsonGetAsset['Data'] as List)
              .map<ModelVehicleDetail>(
                  (data) => ModelVehicleDetail.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelVehicleDetail> list = (jsonGetAsset['Data'] as List)
              .map<ModelVehicleDetail>(
                  (data) => ModelVehicleDetail.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelServiceHistory>> fetchGetService(
    int index,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/BrowseTrans');

    Map mapGetService = {
      "Jenis": "SERVICEHISTORY",
      "PlateNo": GlobalVar.listVehicle[index].plateNumber,
    };

    print('mapGetService');
    print(mapGetService);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapGetService), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      List<ModelServiceHistory> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetAsset = jsonDecode(response.body);
        if (jsonGetAsset['Code'] == '100' && jsonGetAsset['Msg'] == 'Sukses') {
          List<ModelServiceHistory> list = (jsonGetAsset['Data'] as List)
              .map<ModelServiceHistory>(
                  (data) => ModelServiceHistory.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelServiceHistory> list = (jsonGetAsset['Data'] as List)
              .map<ModelServiceHistory>(
                  (data) => ModelServiceHistory.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelFeedsData>> fetchGetFeeds(
    String accessToken,
  ) async {
    var params = {
      'fields': 'id,media_type,media_url,username,timestamp',
      'access_token': accessToken,
    };

    var url =
        Uri.https('graph.instagram.com', '/6972263082890097/media', params);

    print('Get Feeds URL: $url');

    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'Postman/InstagramCollection'},
      ).timeout(const Duration(seconds: 60));

      List<ModelFeedsData> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetFeedsType = jsonDecode(response.body);
        print('jsonGetFeeds Result: $jsonGetFeedsType');
        if (jsonGetFeedsType['data'] != []) {
          List<ModelFeedsData> list = jsonGetFeedsType['data']
              .map<ModelFeedsData>((data) => ModelFeedsData.fromJson(data))
              .toList();

          print('List Result: $list');

          return list;
        } else {
          List<ModelFeedsData> list = [];

          print('List Result: $list');

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelFeedsType>> fetchGetFeedsType(
    String accessToken,
  ) async {
    var params = {
      'fields': 'media_type',
      'access_token': accessToken,
    };

    var url =
        Uri.https('graph.instagram.com', '/6972263082890097/media', params);

    // print('Get Feeds URL: $url');

    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'Postman/InstagramCollection'},
      ).timeout(const Duration(seconds: 60));

      List<ModelFeedsType> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetFeedsType = jsonDecode(response.body);
        print('jsonGetFeedsType Result: $jsonGetFeedsType');
        if (jsonGetFeedsType['Data'] != []) {
          List<ModelFeedsType> list = (jsonGetFeedsType['Data'] as List)
              .map<ModelFeedsType>((data) => ModelFeedsType.fromJson(data))
              .toList();

          print('List Result: $list');

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelFeedsURL>> fetchGetFeedsURL(
    String accessToken,
  ) async {
    var params = {
      'fields': 'media_url',
      'access_token': accessToken,
    };

    var url =
        Uri.https('graph.instagram.com', '/6972263082890097/media', params);

    // print('Get Feeds URL: $url');

    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'Postman/InstagramCollection'},
      ).timeout(const Duration(seconds: 60));

      List<ModelFeedsURL> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetFeedsType = jsonDecode(response.body);
        print('jsonGetFeedsURL Result: $jsonGetFeedsType');
        if (jsonGetFeedsType['Data'] != []) {
          List<ModelFeedsURL> list = (jsonGetFeedsType['Data'] as List)
              .map<ModelFeedsURL>((data) => ModelFeedsURL.fromJson(data))
              .toList();

          print('List Result: $list');

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelNotificationDetail>> fetchGetNotification(
    String isSent,
    String isRead,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/BrowseTrans');

    Map mapGetMessages = {
      "Jenis": "NOTIFICATION",
      "MemberID": GlobalUser.id,
      "IsSent": isSent,
      "IsRead": isRead,
    };

    print('mapGetMessages');
    print(mapGetMessages);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapGetMessages), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      List<ModelNotificationDetail> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetMessage = jsonDecode(response.body);
        if (jsonGetMessage['Code'] == '100' &&
            jsonGetMessage['Msg'] == 'Sukses') {
          List<ModelNotificationDetail> list = (jsonGetMessage['Data'] as List)
              .map<ModelNotificationDetail>(
                  (data) => ModelNotificationDetail.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelNotificationDetail> list = (jsonGetMessage['Data'] as List)
              .map<ModelNotificationDetail>(
                  (data) => ModelNotificationDetail.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<String> fetchModifyNotification(
    String mode,
    String transId,
    String memberId,
    String notificationId,
    String notificationType,
    String notification,
    String isSent,
    String isRead,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Modify');

    Map mapGetMessages = {
      "Mode": mode,
      "TransID": "NOTIFICATION",
      "Data": {
        "MemberID": memberId,
        "NotificationID": notificationId,
        "NotificationType": notificationType,
        "Notification": notification,
        "IsSent": isSent,
        "IsRead": isRead,
      },
    };

    print('mapGetMessages');
    print(mapGetMessages);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapGetMessages), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetMessage = jsonDecode(response.body);
        if (jsonGetMessage['Code'] == '100' &&
            jsonGetMessage['Msg'] == 'Sukses') {
          List<ModelResultMessage> list = [];
          list = (jsonGetMessage['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list[0].resultMessage.toString();
        } else {
          return 'fail';
        }
      }

      return '';
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelResultMessage>> fetchRegistDevice(
    String mode,
    String token,
    String serialNumber,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Modify');

    Map mapRegistDevice = {
      "Mode": mode, //MODE 2 = HAPUS, KALAU LOGOUT DARI DEVICE
      "TransID": "FBTOKEN",
      "Data": {
        "FBToken": token,
        "MemberID": GlobalUser.id,
        "SerialNumber": serialNumber,
      }
    };

    print('mapRegistDevice');
    print(mapRegistDevice);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapRegistDevice), headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 60));

      List<ModelResultMessage> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetMessage = jsonDecode(response.body);
        if (jsonGetMessage['Code'] == '100' &&
            jsonGetMessage['Msg'] == 'Sukses') {
          List<ModelResultMessage> list = (jsonGetMessage['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelResultMessage> list = (jsonGetMessage['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelToken>> fetchGetToken() async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/BrowseTrans');

    Map mapGetToken = {
      "Jenis": "FBTOKEN",
      "MemberID": GlobalUser.id,
    };

    print('mapGetToken');
    print(mapGetToken);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapGetToken), headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 60));

      List<ModelToken> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetMessage = jsonDecode(response.body);
        if (jsonGetMessage['Code'] == '100' &&
            jsonGetMessage['Msg'] == 'Sukses') {
          List<ModelToken> list = (jsonGetMessage['Data'] as List)
              .map<ModelToken>((data) => ModelToken.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelToken> list = (jsonGetMessage['Data'] as List)
              .map<ModelToken>((data) => ModelToken.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<String> fetchSendNotification(
    String token,
    String body,
    String title,
  ) async {
    var url = Uri.https(
        'fcm.googleapis.com', '/v1/projects/fixupmoto-5e9cb/messages:send');

    Map mapSendNotification = {
      "message": {
        "token": token,
        "notification": {
          "body": body,
          "title": title,
        }
      }
    };

    print('mapSendNotification');
    print(mapSendNotification);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapSendNotification), headers: {
        'Content-Type': 'application/json',
        'x-goog-user-project': 'fixupmoto-5e9cb',
      }).timeout(const Duration(seconds: 60));

      String str = '';
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetMessage = jsonDecode(response.body);
        str = (jsonGetMessage['name']);
      } else {
        str = 'fail';
      }

      return str;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelGetVoucher>> fetchGetVoucher(
    String jenis,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Master');

    Map mapGetVoucher = {
      "Jenis": jenis,
    };

    print('mapGetVoucher');
    print(mapGetVoucher);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapGetVoucher), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      List<ModelGetVoucher> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetAsset = jsonDecode(response.body);
        if (jsonGetAsset['Code'] == '100' && jsonGetAsset['Msg'] == 'Sukses') {
          List<ModelGetVoucher> list = (jsonGetAsset['Data'] as List)
              .map<ModelGetVoucher>((data) => ModelGetVoucher.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelGetVoucher> list = (jsonGetAsset['Data'] as List)
              .map<ModelGetVoucher>((data) => ModelGetVoucher.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelResultMessage>> fetchRedeemVoucher(
    String mode,
    String pointID,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Modify');

    Map mapRedeemVoucher = {
      "Mode": mode,
      "TransID": "REDEEMPOINT",
      "Data": {
        "MemberID": GlobalUser.id,
        "PointID": pointID,
      },
    };

    print('mapRedeemVoucher');
    print(mapRedeemVoucher);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapRedeemVoucher), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      List<ModelResultMessage> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetAsset = jsonDecode(response.body);
        if (jsonGetAsset['Code'] == '100' && jsonGetAsset['Msg'] == 'Sukses') {
          List<ModelResultMessage> list = (jsonGetAsset['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelResultMessage> list = (jsonGetAsset['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelWorkshopDetail>> fetchGetWorkshop(
    String jenis,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Master');

    Map mapGetBranch = {
      "Jenis": jenis,
    };

    print('mapGetBranch');
    print(mapGetBranch);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapGetBranch), headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'PostmanRuntime/7.35.0',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
      }).timeout(const Duration(seconds: 60));

      List<ModelWorkshopDetail> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonGetAsset = jsonDecode(response.body);
        if (jsonGetAsset['Code'] == '100' && jsonGetAsset['Msg'] == 'Sukses') {
          List<ModelWorkshopDetail> list = (jsonGetAsset['Data'] as List)
              .map<ModelWorkshopDetail>(
                  (data) => ModelWorkshopDetail.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelWorkshopDetail> list = (jsonGetAsset['Data'] as List)
              .map<ModelWorkshopDetail>(
                  (data) => ModelWorkshopDetail.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<ModelResultMessage>> fetchInsertBookReq(
    String mode,
    String bookingID,
    String bookDate,
    String bookTime,
    String branch,
    String shop,
    String uName,
    String uPhoneNo,
    String uPlateNo,
    String unitID,
    String notes,
    String status,
    String userID,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/Modify');

    Map mapInsertBookReq = {
      "Mode": mode,
      "TransID": "RSV",
      'Data': {
        // BookingID -> MODE 1 BIARKAN KOSONG, MODE 2 : ISIKAN BOOKINGID YANG DIJAWAB
        "BookingID": bookingID,
        "BookDate": bookDate,
        "BookTime": bookTime,
        "Branch": "31",
        "Shop": shop,
        "UName": uName,
        "UPhoneNo": uPhoneNo,
        "UPlateNo": uPlateNo,
        "UnitID": unitID,
        "Notes": notes,
        // Status -> MODE 1 BIARKAN KOSONG, MODE 2 : 0 -- SETUJU, 1 -- DITOLAK
        "Status": status,
        // UserID -> MODE 1 BIARKAN KOSONG, MODE 2: ISI USERID YANG JAWAB
        "UserID": userID, // DARI ADMIN!
        "MemberID": GlobalUser.id,
      }
    };

    print('mapInsertBookReq');
    print(mapInsertBookReq);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapInsertBookReq), headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 60));

      List<ModelResultMessage> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonInsertAsset = jsonDecode(response.body);
        if (jsonInsertAsset['Code'] == '100' &&
            jsonInsertAsset['Msg'] == 'Sukses') {
          List<ModelResultMessage> list = (jsonInsertAsset['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          print(list[0].resultMessage);
          return list;
        } else {
          List<ModelResultMessage> list = (jsonInsertAsset['Data'] as List)
              .map<ModelResultMessage>(
                  (data) => ModelResultMessage.fromJson(data))
              .toList();

          print(list[0].resultMessage);
          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchSetVehicle() async {
    List<Map<String, dynamic>> listSetVehicle = [];
    print('Fetch Set Vehicle');
    try {
      List<Map<String, dynamic>> _listSetVehicle = [];
      listSetVehicle = [];
      listSetVehicle.add({'value': '', 'teks': ''});
      listSetVehicle.addAll(
        await GlobalAPI.fetchGetVehicle().then(
          (data) {
            data.map(
              (ModelVehicleDetail vehicle) {
                if (vehicle.plateNumber != "") {
                  _listSetVehicle.add({
                    'value':
                        '${vehicle.unitID.toString()} - ${vehicle.plateNumber.toString()}',
                    'teks':
                        '${vehicle.unitID.toString()} - ${vehicle.plateNumber.toString()}',
                  });
                }
              },
            ).toList();
            return _listSetVehicle;
          },
        ),
      );

      return listSetVehicle;
    } catch (e) {
      log('IS:error info');
      throw e.toString();
    }
  }

  static Future<List<ModelMemberInvoice>> fetchGetMemberInvoice(
    String kode,
    String beginDate,
    String endDate,
  ) async {
    var url = Uri.https('wsip.yamaha-jatim.co.id:2448', '/apiSAMP/BrowseTrans');

    Map mapInsertBookReq = {
      'Jenis': 'INVOICEBYMEMBER',
      'MemberID': GlobalUser.id,
      'Kode': kode,
      'BeginDate': beginDate,
      'EndDate': endDate,
    };

    print('mapInsertBookReq');
    print(mapInsertBookReq);

    try {
      final response =
          await http.post(url, body: jsonEncode(mapInsertBookReq), headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 60));

      List<ModelMemberInvoice> list = [];
      print(response.body);

      if (response.statusCode <= 200) {
        var jsonInsertAsset = jsonDecode(response.body);
        if (jsonInsertAsset['Code'] == '100' &&
            jsonInsertAsset['Msg'] == 'Sukses') {
          List<ModelMemberInvoice> list = (jsonInsertAsset['Data'] as List)
              .map<ModelMemberInvoice>(
                  (data) => ModelMemberInvoice.fromJson(data))
              .toList();

          return list;
        } else {
          List<ModelMemberInvoice> list = (jsonInsertAsset['Data'] as List)
              .map<ModelMemberInvoice>(
                  (data) => ModelMemberInvoice.fromJson(data))
              .toList();

          return list;
        }
      }

      return list;
    } catch (e) {
      return throw e;
    }
  }
}
