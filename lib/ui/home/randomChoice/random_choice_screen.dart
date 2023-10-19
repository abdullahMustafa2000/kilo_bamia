import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/randomChoice/random_choice_pageview.dart';

class RandomChoiceWidget extends StatelessWidget {
  RandomChoiceWidget({required this.onClickClose, required this.adInitializer});
  Function onClickClose;
  AdInitializer adInitializer;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColors.lightBlack.withOpacity(.86),
        ),
        RandomChoicePageView(onCloseClick: onClickClose, adInitializer: adInitializer,),
      ],

    );
  }
}
