import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/app_tour/page_view_widget.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:kilo_bamya/ui/elements/spinning_wheel.dart';
import 'package:kilo_bamya/ui/home/home_screen.dart';

int _wheelSpinSeconds = 3;
int _fadeOutMilliSeconds = 1000;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> _fadeOutAnimation;

  late AnimationController _fadeOutController;

  late AnimationController _offsetAnimationController;
  late Animation<Offset> _upOffsetAnimation, _downOffsetAnimation;

  late Future<bool> _isFirstRunFut;

  Future<bool> _getFirstRunFuture() async {
    return await IsFirstRun.isFirstRun();
  }

  @override
  void initState() {
    _isFirstRunFut = _getFirstRunFuture();
    super.initState();
    _fadeOutController =
        AnimationController(vsync: this, duration: Duration(milliseconds: _fadeOutMilliSeconds));
    _fadeOutAnimation =
        Tween<double>(begin: 1, end: 0).animate(_fadeOutController);

    _offsetAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _fadeOutMilliSeconds));
    _downOffsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 2.0))
            .animate(_offsetAnimationController);
    _upOffsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -2.0))
            .animate(_offsetAnimationController);

    Future.delayed(Duration(seconds: _wheelSpinSeconds + 1), () {
      _fadeOutController.forward();
      _offsetAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder<bool>(
              future: _isFirstRunFut,
              builder: (context, snap) {
                return _afterAnimWidget(snap.data ?? true);
              }),
          Column(
            children: [
              TopScreen(
                fadeOutAnimation: _fadeOutAnimation,
                slideUpAnimation: _upOffsetAnimation,
              ),
              BottomScreen(
                fadeOutAnimation: _fadeOutAnimation,
                slideDownAnimation: _downOffsetAnimation,
              ),
            ],
          ),
          OverlayContent(
            fadeOutAnimation: _fadeOutAnimation,
          ),
        ],
      ),
    );
  }

  Widget _afterAnimWidget(bool firstRun) {
    return firstRun ? TourPageView() : const HomePage();
  }
}

class BottomScreen extends StatelessWidget {
  final Animation<double> fadeOutAnimation;
  final Animation<Offset> slideDownAnimation;
  BottomScreen(
      {required this.fadeOutAnimation,
      required this.slideDownAnimation,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SlideTransition(
        position: slideDownAnimation,
        child: FadeTransition(
          opacity: fadeOutAnimation,
          child: Container(
            color: MyColors.lightBlack,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}

class NameOfAppTextDesign extends StatelessWidget {
  final String name;
  final Color color;
  const NameOfAppTextDesign({Key? key, required this.name, required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: GoogleFonts.k2d(
          textStyle: TextStyle(
              color: color,
              fontSize: 50,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class OverlayContent extends StatefulWidget {
  OverlayContent({super.key, required this.fadeOutAnimation});
  final Animation<double> fadeOutAnimation;
  @override
  State<OverlayContent> createState() => _OverlayContentState();
}

class _OverlayContentState extends State<OverlayContent>
    with TickerProviderStateMixin {
  late Animation<double> _fadeInAnimation;

  late AnimationController _fadeInController;

  @override
  void initState() {
    super.initState();
    _fadeInController =
        AnimationController(vsync: this, duration: Duration(milliseconds: _fadeOutMilliSeconds));
    _fadeInAnimation =
        Tween<double>(begin: 0, end: 1).animate(_fadeInController);

    Future.delayed(Duration(milliseconds: _wheelSpinSeconds * 1000 + 50), () {
      _fadeInController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> nameOfApp = getLocalization(context).appName.split(' ');
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
      child: Column(
        children: [
          FadeTransition(
            opacity: widget.fadeOutAnimation,
            child: SpinningWheel(
              animDuration: _wheelSpinSeconds,
              wheelPerc: .5,
              kittyPerc: .4,
              wheelAnimController: (AnimationController controller) {
                Future.delayed(Duration(seconds: _wheelSpinSeconds), () {
                  controller.stop();
                });
              },
              kittyFadeOutAnimation: _fadeInAnimation,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          FadeTransition(
            opacity: widget.fadeOutAnimation,
            child: Column(
              children: [
                NameOfAppTextDesign(
                    name: nameOfApp[0], color: MyColors.darkBlue),
                NameOfAppTextDesign(name: nameOfApp[1], color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopScreen extends StatelessWidget {
  final Animation<double> fadeOutAnimation;
  final Animation<Offset> slideUpAnimation;
  TopScreen(
      {required this.fadeOutAnimation,
      required this.slideUpAnimation,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SlideTransition(
      position: slideUpAnimation,
      child: FadeTransition(
        opacity: fadeOutAnimation,
        child: Container(
          height: screenSize.height * .3,
          width: double.infinity,
          color: MyColors.darkBlue,
        ),
      ),
    );
  }
}