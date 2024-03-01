import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:flutter/material.dart';

class NotificationChangeNotifier extends ChangeNotifier {
  // int _currentIndex = 0;

  // int getCurrentIndex() => _currentIndex;

  void notify(List<ModelNotificationDetail> list) {
    GlobalVar.listNotificationDetail = list;
    notifyListeners();
  }
}
