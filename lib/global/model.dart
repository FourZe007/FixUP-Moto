class ModelResultMessage {
  String resultMessage;

  ModelResultMessage({required this.resultMessage});

  factory ModelResultMessage.fromJson(Map<String, dynamic> json) {
    return ModelResultMessage(resultMessage: json['ResultMessage']);
  }
}

class ModelUser {
  int flag;
  String memo;
  String memberID;
  String memberName;

  ModelUser({
    required this.flag,
    required this.memo,
    required this.memberID,
    required this.memberName,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      flag: json['Flag'],
      memo: json['Memo'],
      memberID: json['MemberID'],
      memberName: json['MemberName'],
    );
  }
}

class ModelBrowseUser {
  String status;
  String memberID;
  String memberName;
  String email;
  String phoneNumber;
  bool isActive;
  int qty;
  int points;
  List<dynamic> detail;
  List<dynamic> detail2;

  ModelBrowseUser({
    required this.status,
    required this.memberID,
    required this.memberName,
    required this.email,
    required this.phoneNumber,
    required this.isActive,
    required this.qty,
    required this.points,
    required this.detail,
    required this.detail2,
  });

  // sini
  factory ModelBrowseUser.fromJson(Map<String, dynamic> json) {
    return ModelBrowseUser(
      status: json['Status'],
      memberID: json['MemberID'],
      memberName: json['MemberName'],
      email: json['EmailAddress'],
      phoneNumber: json['PhoneNo'],
      isActive: json['Active'],
      qty: json['Qty'],
      points: json['Point'],
      detail: json['Detail']
          .map((dynamic data) => ModelBrowseUserDetail1.fromJson(data))
          .toList(),
      detail2: json['Detail2']
          .map((dynamic data) => ModelBrowseUserDetail2.fromJson(data))
          .toList(),
    );
  }
}

class ModelBrowseUserDetail1 {
  String transDate;
  String pointID;
  String pointName;
  int pointQty;

  ModelBrowseUserDetail1({
    required this.transDate,
    required this.pointID,
    required this.pointName,
    required this.pointQty,
  });

  factory ModelBrowseUserDetail1.fromJson(Map<String, dynamic> json) {
    return ModelBrowseUserDetail1(
      transDate: json['TransDate'],
      pointID: json['PointID'],
      pointName: json['PointName'],
      pointQty: json['PointQty'],
    );
  }
}

class ModelBrowseUserDetail2 {
  String redeemDate;
  String expiredDate;
  String voucherNumber;
  int voucherState;
  String voucherID;
  String voucherName;
  String voucherMemoState;

  ModelBrowseUserDetail2({
    required this.redeemDate,
    required this.expiredDate,
    required this.voucherNumber,
    required this.voucherState,
    required this.voucherID,
    required this.voucherName,
    required this.voucherMemoState,
  });

  factory ModelBrowseUserDetail2.fromJson(Map<String, dynamic> json) {
    return ModelBrowseUserDetail2(
      redeemDate: json['RedeemDate'],
      expiredDate: json['ExpirationDate'],
      voucherNumber: json['VoucherNo'],
      voucherState: json['StatusVoucher'],
      voucherID: json['VoucherID'],
      voucherName: json['VoucherName'],
      voucherMemoState: json['StatusVoucherMemo'],
    );
  }
}

class ModelSendOTP {
  String resultMessage;

  ModelSendOTP({required this.resultMessage});

  factory ModelSendOTP.fromJson(Map<String, dynamic> json) {
    return ModelSendOTP(resultMessage: json['status']);
  }
}

class ModelUserCheck {
  List<ModelNotificationDetail> notification;
  String deviceName;
  List<ModelBrowseUser> userData;
  List<ModelVehicleDetail> vehicleDetail;
  List<dynamic> controllerLink;
  List<dynamic> controllerType;

  ModelUserCheck({
    required this.notification,
    required this.deviceName,
    required this.userData,
    required this.vehicleDetail,
    required this.controllerLink,
    required this.controllerType,
  });
}

class ModelVehicleDetail {
  String unitID;
  String plateNumber;
  String chasisNumber;
  String engineNumber;
  String color;
  String year;
  String photo;
  int line;

  ModelVehicleDetail({
    required this.unitID,
    required this.plateNumber,
    required this.chasisNumber,
    required this.engineNumber,
    required this.color,
    required this.year,
    required this.photo,
    required this.line,
  });

  factory ModelVehicleDetail.fromJson(Map<String, dynamic> json) {
    return ModelVehicleDetail(
      unitID: json['UnitID'],
      plateNumber: json['PlateNo'],
      chasisNumber: json['ChasisNo'],
      engineNumber: json['EngineNo'],
      color: json['Color'],
      year: json['Year'],
      photo: json['Photo'],
      line: json['Line'],
    );
  }
}

class ModelGetVoucher {
  String pointID;
  String pointName;
  int pointQty;

  ModelGetVoucher({
    required this.pointID,
    required this.pointName,
    required this.pointQty,
  });

  factory ModelGetVoucher.fromJson(Map<String, dynamic> json) {
    return ModelGetVoucher(
      pointID: json['PointID'],
      pointName: json['PointName'],
      pointQty: json['PointQty'],
    );
  }
}

class ModelServiceHistory {
  String workshopName;
  String transNo;
  String transDate;
  String name;
  double serviceAmount;
  double partAmount;
  List<dynamic> detail;
  List<dynamic> detail2;

  ModelServiceHistory({
    required this.workshopName,
    required this.transNo,
    required this.transDate,
    required this.name,
    required this.serviceAmount,
    required this.partAmount,
    required this.detail,
    required this.detail2,
  });

  factory ModelServiceHistory.fromJson(Map<String, dynamic> json) {
    return ModelServiceHistory(
      workshopName: json['BSName'],
      transNo: json['TransNo'],
      transDate: json['TransDate'],
      name: json['EName'],
      serviceAmount: json['AmountService'],
      partAmount: json['AmountPart'],
      detail: json['Detail']
          .map((dynamic data) => ModelServiceHistoryDetail1.fromJson(data))
          .toList(),
      detail2: json['Detail2']
          .map((dynamic data) => ModelServiceHistoryDetail2.fromJson(data))
          .toList(),
    );
  }
}

class ModelServiceHistoryDetail1 {
  String serviceID;
  String serviceName;
  String serviceNote;

  ModelServiceHistoryDetail1({
    required this.serviceID,
    required this.serviceName,
    required this.serviceNote,
  });

  factory ModelServiceHistoryDetail1.fromJson(Map<String, dynamic> json) {
    return ModelServiceHistoryDetail1(
      serviceID: json['ServiceID'],
      serviceName: json['ServiceName'],
      serviceNote: json['ServiceNote'],
    );
  }
}

class ModelServiceHistoryDetail2 {
  String unitID;
  String itemName;
  int qty;

  ModelServiceHistoryDetail2({
    required this.unitID,
    required this.itemName,
    required this.qty,
  });

  factory ModelServiceHistoryDetail2.fromJson(Map<String, dynamic> json) {
    return ModelServiceHistoryDetail2(
      unitID: json['UnitID'],
      itemName: json['ItemName'],
      qty: json['Qty'],
    );
  }
}

class ModelFeeds {
  List<ModelFeedsData>? data;
  ModelFeedsPaging? paging;

  ModelFeeds({
    required this.data,
    required this.paging,
  });

  // sini
  factory ModelFeeds.fromJson(Map<String, dynamic> json) {
    return ModelFeeds(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((dynamic data) => ModelFeedsData.fromJson(data))
              .toList()
          : null,
      // data: (json['data'] as List)
      //     .map((item) => ModelFeedsData.fromJson(item))
      //     .toList(),
      paging: json['paging'] != null
          ? ModelFeedsPaging.fromJson(json['paging'])
          : null,
    );
  }
}

class ModelFeedsData {
  String id;
  String mediatype;
  String mediaurl;
  String username;
  String timestamp;

  ModelFeedsData({
    required this.id,
    required this.mediatype,
    required this.mediaurl,
    required this.username,
    required this.timestamp,
  });

  factory ModelFeedsData.fromJson(Map<String, dynamic> json) {
    return ModelFeedsData(
      id: json['id'],
      mediatype: json['media_type'],
      mediaurl: json['media_url'],
      username: json['username'],
      timestamp: json['timestamp'],
    );
  }
}

class ModelAccessToken {
  String accessToken;
  String bearer;
  int duration;

  ModelAccessToken({
    required this.accessToken,
    required this.bearer,
    required this.duration,
  });

  factory ModelAccessToken.fromJson(Map<String, dynamic> json) {
    return ModelAccessToken(
      accessToken: json['access_token'],
      bearer: json['token_type'],
      duration: json['expires_in'],
    );
  }
}

class ModelFeedsPaging {
  ModelFeedsCursors? cursors;
  String next;

  ModelFeedsPaging({
    required this.cursors,
    required this.next,
  });

  factory ModelFeedsPaging.fromJson(Map<String, dynamic> json) {
    return ModelFeedsPaging(
      cursors: json['cursors'] != null
          ? ModelFeedsCursors.fromJson(json['cursors'])
          : null,
      next: json['next'],
    );
  }
}

class ModelFeedsCursors {
  String before;
  String after;

  ModelFeedsCursors({
    required this.before,
    required this.after,
  });

  factory ModelFeedsCursors.fromJson(Map<String, dynamic> json) {
    return ModelFeedsCursors(
      before: json['before'],
      after: json['after'],
    );
  }
}

class ModelFeedsType {
  String mediatype;
  String id;

  ModelFeedsType({
    required this.mediatype,
    required this.id,
  });

  factory ModelFeedsType.fromJson(Map<String, dynamic> json) {
    return ModelFeedsType(
      mediatype: json['media_type'],
      id: json['id'],
    );
  }
}

class ModelFeedsURL {
  String mediaurl;
  String id;

  ModelFeedsURL({
    required this.mediaurl,
    required this.id,
  });

  factory ModelFeedsURL.fromJson(Map<String, dynamic> json) {
    return ModelFeedsURL(
      mediaurl: json['media_url'],
      id: json['id'],
    );
  }
}

class ModelNotificationDetail {
  String memberID;
  String notifID;
  String notifType;
  String notif;
  String date;
  String isSent;
  String isRead;
  int q;

  ModelNotificationDetail({
    required this.memberID,
    required this.notifID,
    required this.notifType,
    required this.notif,
    required this.date,
    required this.isSent,
    required this.isRead,
    required this.q,
  });

  factory ModelNotificationDetail.fromJson(Map<String, dynamic> json) {
    return ModelNotificationDetail(
      memberID: json['MemberID'],
      notifID: json['NotificationID'],
      notifType: json['NotificationType'],
      notif: json['Notification'],
      date: json['SysDate'],
      isSent: json['IsSent'],
      isRead: json['IsRead'],
      q: json['Q'],
    );
  }
}

class ModelToken {
  String memberID;
  String token;
  String serialNumber;

  ModelToken({
    required this.memberID,
    required this.token,
    required this.serialNumber,
  });

  factory ModelToken.fromJson(Map<String, dynamic> json) {
    return ModelToken(
      memberID: json['MemberID'],
      token: json['FBToken'],
      serialNumber: json['SerialNumber'],
    );
  }
}

class ModelWorkshopDetail {
  String branch;
  String shop;
  String name;
  String address;
  String operation;
  String phone;
  bool isOpen;
  double latitude;
  double longitude;

  ModelWorkshopDetail({
    required this.branch,
    required this.shop,
    required this.name,
    required this.address,
    required this.operation,
    required this.phone,
    required this.isOpen,
    required this.latitude,
    required this.longitude,
  });

  factory ModelWorkshopDetail.fromJson(Map<String, dynamic> json) {
    return ModelWorkshopDetail(
      branch: json['Branch'],
      shop: json['Shop'],
      name: json['BSName'],
      address: json['BSAddress'],
      operation: json['OperasionalHours'],
      phone: json['PhoneNo'],
      isOpen: json['Active'],
      latitude: json['Lat'],
      longitude: json['Lng'],
    );
  }
}

class ModelMemberInvoice {
  String jenis;
  String bsName;
  String transNo;
  String transDate;
  String voucherNo;
  String voucherName;
  int qty;
  double priceNett;
  double discNett;
  double totalNett;
  List<dynamic> detail;

  ModelMemberInvoice({
    required this.jenis,
    required this.bsName,
    required this.transNo,
    required this.transDate,
    required this.voucherNo,
    required this.voucherName,
    required this.qty,
    required this.priceNett,
    required this.discNett,
    required this.totalNett,
    required this.detail,
  });

  factory ModelMemberInvoice.fromJson(Map<String, dynamic> json) {
    return ModelMemberInvoice(
      jenis: json['Jenis'],
      bsName: json['BSName'],
      transNo: json['TransNo'],
      transDate: json['TransDate'],
      voucherNo: json['VoucherNo'],
      voucherName: json['VoucherName'],
      qty: json['TQty'],
      priceNett: json['TPriceNett'],
      discNett: json['TDiscNett'],
      totalNett: json['TotalNett'],
      detail: json['Detail']
          .map((dynamic data) => ModelMemberInvoiceDetail.fromJson(data))
          .toList(),
    );
  }
}

class ModelMemberInvoiceDetail {
  String unitID;
  String itemName;
  String itemNote;
  int qty;
  double priceNett;
  double discNett;

  ModelMemberInvoiceDetail({
    required this.unitID,
    required this.itemName,
    required this.itemNote,
    required this.qty,
    required this.priceNett,
    required this.discNett,
  });

  factory ModelMemberInvoiceDetail.fromJson(Map<String, dynamic> json) {
    return ModelMemberInvoiceDetail(
      unitID: json['UnitID'],
      itemName: json['ItemName'],
      itemNote: json['ItemNote'],
      qty: json['Qty'],
      priceNett: json['PriceNett'],
      discNett: json['DiscNett'],
    );
  }
}
