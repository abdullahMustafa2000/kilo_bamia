import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/enter_choices_page.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/result_page.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/spinning_wheel_page.dart';

import '../../../moduls/choice_class_model.dart';

class RandomChoicePageView extends StatelessWidget {
  RandomChoicePageView({required this.onCloseClick});
  Function onCloseClick;
  var currentPage = 0;
  final _controller = PageController();
  static List<ChoiceModel> mChoicesList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          EnterChoicesPage(
            onCloseClick: onCloseClick,
            onSpinningWheelClick: moveToNextPage,
          ),
          AnimationPage(
            onCloseClick: onCloseClick,
            onBackClick: moveToInitialPage,
            onMoveToNext: moveToNextPage,
          ),
          ChoiceResultPage(onCloseClick: onCloseClick)
        ],
      ),
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
