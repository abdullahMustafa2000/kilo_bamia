import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/enter_choices_page.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/result_page.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/spinning_wheel_page.dart';

import '../../../models/choice_class_model.dart';

class RandomChoicePageView extends StatelessWidget {
  RandomChoicePageView({required this.onCloseClick});
  Function onCloseClick;
  var currentPage = 0;
  late AdInitializer _adInitializer;
  final _controller = PageController();
  static List<ChoiceModel> mChoicesList = [];
  @override
  Widget build(BuildContext context) {
    _adInitializer = AdInitializer();
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      children: [
        EnterChoicesPage(
          onCloseClick: onCloseClick,
          onSpinningWheelClick: moveToNextPage,
        ),
        AnimationPage(
          adInitializer: _adInitializer,
          onCloseClick: onCloseClick,
          onBackClick: moveToInitialPage,
          onMoveToNext: moveToNextPage,
        ),
        ChoiceResultPage(onCloseClick: onCloseClick)
      ],
    );
  }

  void moveToNextPage(List<ChoiceModel> choices) {
    if (choices.isNotEmpty) {
      mChoicesList = choices;
    }
    _controller.animateToPage(currentPage += 1,
        duration: const Duration(microseconds: 400), curve: Curves.bounceIn);
  }

  void moveToInitialPage() {
    _controller.animateToPage(currentPage = 0,
        duration: const Duration(microseconds: 400), curve: Curves.bounceIn);
  }
}
