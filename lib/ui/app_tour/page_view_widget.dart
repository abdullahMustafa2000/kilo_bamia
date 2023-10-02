// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/ui/app_tour/page_design.dart';
import 'package:kilo_bamya/ui/app_tour/view_page_provider.dart';
import 'package:kilo_bamya/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

class TourPageView extends StatefulWidget {
  @override
  State<TourPageView> createState() => _TourPageViewState();
}

class _TourPageViewState extends State<TourPageView> {
  final _controller = PageController();

  late MyViewPageProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyViewPageProvider>(context);

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
                index: 0),
            IntroPage(
                title: getLocalization(context).tourFinalTitle,
                desc:
                    getLocalization(context).tourFinalDesc,
                btnTxt: getLocalization(context).startBtn,
                view: Image.asset('assets/images/kitty.png'),
                onBtnClick: onBtnClick,
                index: 0),
          ],
        ),
      ),
    );
  }

  void onBtnClick(String txt) {
    if (txt.toLowerCase() == 'Next'.toLowerCase()) {
      provider.updateIndex();
      _controller.animateToPage(provider.currentPageIndex,
          duration: const Duration(milliseconds: 400), curve: Curves.ease);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }
}
