import 'package:flutter/material.dart';

class BtmNavProvider extends ChangeNotifier {
  late int btmIndex;

  BtmNavProvider() {
    btmIndex = 0;
  }

  updateBtnNavIndex(int index) {
    if (index == btmIndex) {
      return;
    }
    btmIndex = index;
    notifyListeners();
  }
}