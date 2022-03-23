import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/randomChoice/random_choice_pageview.dart';

class RandomChoiceWidget extends StatelessWidget {
  RandomChoiceWidget({required this.onClickClose});
  Function onClickClose;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColors.lightBlack.withOpacity(.86),
        ),
        RandomChoicePageView(onCloseClick: onClickClose,),
      ],

    );
  }
}
