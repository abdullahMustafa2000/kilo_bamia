import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/enter_choices_page.dart';

class RandomChoicePageView extends StatelessWidget {
  RandomChoicePageView({required this.onCloseClick});
  Function onCloseClick;
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          EnterChoicesPage(onCloseClick: onCloseClick,),
          //AnimationPage(),
          //ChoiceResultPage()
        ],
      ),
    );
  }
}
