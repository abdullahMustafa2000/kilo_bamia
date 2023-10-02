// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/ui/app_tour/page_design.dart';
import 'package:kilo_bamya/ui/home/home_screen.dart';

class TourPageView extends StatefulWidget {
  @override
  State<TourPageView> createState() => _TourPageViewState();
}

class _TourPageViewState extends State<TourPageView> {
  final _controller = PageController();
  late int curIndex;
  @override
  void initState() {
    curIndex = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            IntroPage(
                title: getLocalization(context).tour1Title,
                desc:
                    getLocalization(context).tour1Desc,
                btnTxt: getLocalization(context).createSplit,
                view: Image.asset('assets/images/hands.png'),
                onBtnClick: onBtnClick,
                index: 0),
            IntroPage(
                title: getLocalization(context).tour2Title,
                desc:
                    getLocalization(context).tour2Desc,
                btnTxt: getLocalization(context).createSplit,
                view: Row(
                  children: [
                    Image.asset('assets/images/spinning_wheel.png',
                        width: 140, height: 140),
                    Image.asset(
                      'assets/images/throw_coin.png',
                      width: 140,
                      height: 140,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                onBtnClick: onBtnClick,
                index: 1),
            IntroPage(
                title: getLocalization(context).tourFinalTitle,
                desc:
                    getLocalization(context).tourFinalDesc,
                btnTxt: getLocalization(context).startBtn,
                view: Image.asset('assets/images/kitty.png'),
                onBtnClick: onBtnClick,
                index: 2),
          ],
        ),
      ),
    );
  }

  void onBtnClick(int index) {
    if (index < 2) {
      _controller.animateToPage(++curIndex,
          duration: const Duration(milliseconds: 400), curve: Curves.ease);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }
}
