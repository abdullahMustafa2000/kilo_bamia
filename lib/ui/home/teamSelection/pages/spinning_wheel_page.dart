import 'package:flutter/material.dart';

class SpinningWheelWidget extends StatelessWidget {
  Function onLoadEnd;

  SpinningWheelWidget({required this.onLoadEnd});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future.delayed(const Duration(milliseconds: 1500), () {
      onLoadEnd();
    });
    return Center(child: Image.asset('assets/images/spinning_wheel.png', width: size.width * .4,));
  }
}
