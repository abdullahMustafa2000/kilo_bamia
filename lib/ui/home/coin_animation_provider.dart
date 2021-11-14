import 'package:flutter/material.dart';

class CoinAnimationProvider extends ChangeNotifier {

  late bool _animationIsOn;

  CoinAnimationProvider() {
    _animationIsOn = false;
  }

  bool get animationHasStarted => _animationIsOn;

  startAnimation() {
    _animationIsOn = true;
    notifyListeners();
  }

  endAnimation() {
    _animationIsOn = false;
    notifyListeners();
  }

}