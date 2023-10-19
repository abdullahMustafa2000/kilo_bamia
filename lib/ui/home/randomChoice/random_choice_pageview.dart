import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/ui/elements/loading_wheel_screen.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/enter_choices_page.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/result_page.dart';

import '../../../models/choice_class_model.dart';

class RandomChoicePageView extends StatelessWidget {
  RandomChoicePageView({required this.onCloseClick, required this.adInitializer});
  final Function onCloseClick;
  int currentPage = 0;
  final AdInitializer adInitializer;
  final _controller = PageController();
  static List<ChoiceModel> mChoicesList = [];
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      children: [
        EnterChoicesPage(
          onCloseClick: onCloseClick,
          onSpinningWheelClick: moveToNextPage,
        ),
        LoadingResultScreen(
          onCloseClick: onCloseClick,
          onBackClick: moveToInitialPage,
          onMoveToNext: moveToNextPage,
        ),
        ChoiceResultPage(onCloseClick: onCloseClick, adInitializer: adInitializer)
      ],
    );
  }

  void moveToNextPage({List<ChoiceModel>? choices}) {
    if (choices != null && choices.isNotEmpty) {
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
