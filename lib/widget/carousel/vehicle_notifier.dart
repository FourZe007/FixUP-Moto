import 'package:fixupmoto/global/global.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:flutter/material.dart';

class VehicleChangeNotifier extends ChangeNotifier {
  // int _currentIndex = 0;

  // int getCurrentIndex() => _currentIndex;

  void notify(List<ModelVehicleDetail> list) {
    GlobalVar.listVehicle = list;
    notifyListeners();
  }
}
