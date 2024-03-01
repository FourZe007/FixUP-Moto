import 'package:fixupmoto/global/api.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:flutter/material.dart';

class NotificationLengthChangeNotifier extends ChangeNotifier {
  List<ModelNotificationDetail> list = [];

  getList() async => list = await GlobalAPI.fetchGetNotification('1', '0');

  void notify() {
    print('Get Provider Data!');
    getList();
    // GlobalVar.notificationDetailLength = list.length;
    notifyListeners();
  }
}
