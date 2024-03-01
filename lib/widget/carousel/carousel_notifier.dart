import 'package:flutter/material.dart';

class CarouselChangeNotifier extends ChangeNotifier {
  // int _currentIndex = 0;

  // int getCurrentIndex() => _currentIndex;

  void notify(int index, int currentIndex) {
    currentIndex = index;
    notifyListeners();
  }
}
