import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/app_tour/page_view_widget.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:kilo_bamya/ui/elements/spinning_wheel.dart';
import 'package:kilo_bamya/ui/home/home_screen.dart';

int _wheelSpinMilliseconds = 2000;
int _fadeOutMilliseconds = 1000;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> _fadeOutAnimation;

  late AnimationController _fadeOutController, _offsetAnimationController;

  late Animation<Offset> _upOffsetAnimation, _downOffsetAnimation;

  late Future<bool> _isFirstRunFut;

  Future<bool> _getFirstRunFuture() async {
    return await IsFirstRun.isFirstRun();
  }

  @override
  void initState() {
    _isFirstRunFut = _getFirstRunFuture();
    super.initState();
    _fadeOutController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _fadeOutMilliseconds));
    _fadeOutAnimation =
        Tween<double>(begin: 1, end: 0).animate(_fadeOutController);

    _offsetAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _fadeOutMilliseconds));
    _downOffsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 2.0))
            .animate(_offsetAnimationController);
    _upOffsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -2.0))
            .animate(_offsetAnimationController);

    //start background animation
    Future.delayed(
        Duration(milliseconds: (_wheelSpinMilliseconds * 2.1).round()), () {
      _fadeOutController.forward();
      _offsetAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          //get sharedPref to choose between moving to home or landing page
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
          OverlayContent(),
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
  OverlayContent({super.key});
  @override
  State<OverlayContent> createState() => _OverlayContentState();
}

class _OverlayContentState extends State<OverlayContent>
    with TickerProviderStateMixin {
  late Animation<double> _fadeInAnimation, _fadeOutAnimation;

  late AnimationController _fadeInController, _fadeOutController;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _fadeOutMilliseconds));
    _fadeInAnimation =
        Tween<double>(begin: 0, end: 1).animate(_fadeInController);

    _fadeOutController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _fadeOutMilliseconds));
    _fadeOutAnimation =
        Tween<double>(begin: 1, end: 0).animate(_fadeOutController);

    Future.delayed(Duration(milliseconds: _wheelSpinMilliseconds + 200), () {
      _fadeInController.forward();
      Future.delayed(Duration(milliseconds: 1000), () {
        _fadeOutController.forward();
      });
    });
    _fadeOutController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilt');
    List<String> nameOfApp = getLocalization(context).appName.split(' ');
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
      child: _fadeOutController.status == AnimationStatus.completed
          ? SizedBox.shrink()
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _fadeOutAnimation,
                      child: SpinningWheel(
                        animDurationInSec: 3,
                        wheelPerc: .5,
                        kittyPerc: .4,
                        wheelAnimController: (AnimationController controller) {
                          Future.delayed(
                              Duration(milliseconds: _wheelSpinMilliseconds),
                              () {
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
                      opacity: _fadeOutAnimation,
                      child: Column(
                        children: [
                          NameOfAppTextDesign(
                              name: '${nameOfApp[0]} ${nameOfApp[1]}',
                              color: MyColors.darkBlue),
                          NameOfAppTextDesign(
                              name: nameOfApp[2], color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
/*
1- spin the wheel for 1500 milliseconds //1500
2- delay stop spinning the wheel in 1500 milliseconds //1500
3- delay 1600 milliseconds to start cat fadeIn //1600
4- delay 2100 milliseconds to fadeout overlay widget //2600
5- delay 2500 milliseconds to start background animation // 2500
*/
