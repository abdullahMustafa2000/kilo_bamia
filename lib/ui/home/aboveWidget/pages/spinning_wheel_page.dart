import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/teams_provider.dart';
import 'package:provider/provider.dart';

class SpinningWheelWidget extends StatelessWidget {
  Function onLoadEnd;

  SpinningWheelWidget({required this.onLoadEnd});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<TeamProvider>(context);
    Future.delayed(const Duration(seconds: 3), () {
      onLoadEnd();
    });
    return Center(child: Image.asset('assets/images/spinning_wheel.png', width: size.width * .4,));
  }
}
