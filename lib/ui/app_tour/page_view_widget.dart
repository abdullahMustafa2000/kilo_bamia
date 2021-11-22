// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/app_tour/page_design.dart';
import 'package:kilo_bamya/ui/app_tour/view_page_provider.dart';
import 'package:kilo_bamya/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

class MyPageViewController extends StatefulWidget {

  @override
  State<MyPageViewController> createState() => _MyPageViewControllerState();
}

class _MyPageViewControllerState extends State<MyPageViewController> {
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
            IntroPage(title: 'Kilo Bamya', desc: 'Kilo Bamia is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.', btnTxt: 'Next', view: Image.asset('assets/images/spinning_wheel.png'), onBtnClick: onBtnClick, index: 0),
            IntroPage(title: 'Kilo Bamya', desc: 'Kilo Bamia is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.', btnTxt: 'Next', view: Row(children: [Image.asset('assets/images/spinning_wheel.png', width: 140, height: 140), Image.asset('assets/images/throw_coin.png', width: 140, height: 140,)], mainAxisAlignment: MainAxisAlignment.spaceEvenly,), onBtnClick: onBtnClick, index: 0),
            IntroPage(title: 'Kilo Bamya', desc: 'Kilo Bamia is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.', btnTxt: 'Start', view: Image.asset('assets/images/kitty.png'), onBtnClick: onBtnClick, index: 0),
          ],
        ),
      ),
    );
  }

  void onBtnClick(String txt) {
    if (txt.toLowerCase() == 'Next'.toLowerCase()) {
      provider.updateIndex();
      _controller.animateToPage(provider.currentPageIndex,
          duration: const Duration(milliseconds: 400), curve: Curves.bounceOut);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomePage()));
    }
  }
}
