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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.adInitializer.disposeAd();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future.delayed(const Duration(milliseconds: 1500), () {
      widget.onLoadEnd();
      widget.adInitializer.showInterstitialAd();
    });
    return Center(child: ImagesStack(size: size));
  }
}

class ImagesStack extends StatefulWidget {
  Size size;

  ImagesStack({required this.size});

  @override
  State<ImagesStack> createState() => _ImagesStackState();
}

class _ImagesStackState extends State<ImagesStack>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        RotationTransition(
            turns: _animation,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/spinning_wheel.png',
              width: size.width * .8,
            )),
        Image.asset(
          'assets/images/kitty.png',
          width: size.width * .25,
        ),
      ],
    );
  }
}
