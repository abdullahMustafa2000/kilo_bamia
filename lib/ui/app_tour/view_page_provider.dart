import 'package:flutter/cupertino.dart';

class MyViewPageProvider extends ChangeNotifier {
  late int currentPageIndex;
  late ValueNotifier<int> currentPageNotifier;
  MyViewPageProvider() {
    currentPageIndex = 0;
    currentPageNotifier = ValueNotifier<int>(0);
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
    currentPageNotifier.value = index;
    notifyListeners();
  }

  void updateIndex() {
    onPageChanged(currentPageIndex+=1);
  }

}