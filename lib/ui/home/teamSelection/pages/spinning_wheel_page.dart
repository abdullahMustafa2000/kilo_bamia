import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';

class SpinningWheelWidget extends StatefulWidget {
  Function onLoadEnd;
  AdInitializer adInitializer;
  SpinningWheelWidget({required this.onLoadEnd, required this.adInitializer});

  @override
  State<SpinningWheelWidget> createState() => _SpinningWheelWidgetState();
}

class _SpinningWheelWidgetState extends State<SpinningWheelWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.adInitializer.showInterstitialAd();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.adInitializer.disposeAd();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future.delayed(const Duration(milliseconds: 1500), () {
      widget.onLoadEnd();
    });
    return Center(child: Image.asset('assets/images/spinning_wheel.png', width: size.width * .4,));
  }
}
