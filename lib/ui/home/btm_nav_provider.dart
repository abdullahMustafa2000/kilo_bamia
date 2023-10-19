import 'package:flutter/material.dart';

class HomeClicksProvider extends ChangeNotifier {
  late int btmIndex;

  HomeClicksProvider() {
    btmIndex = 0;
  }

  void updateBtnNavIndex(int index) {
    if (index == btmIndex) return;
    btmIndex = index;
    notifyListeners();
  }
}