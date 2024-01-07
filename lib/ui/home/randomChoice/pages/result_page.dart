import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/enter_choices_page.dart';
import 'package:kilo_bamya/ui/home/randomChoice/random_choice_pageview.dart';
import '../../../../models/choice_class_model.dart';
import '../../../elements/circular_container.dart';
import '../../../elements/icon_btn.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';

class ChoiceResultPage extends StatefulWidget {
  final Function onCloseClick;
  final AdInitializer adInitializer;
  ChoiceResultPage({required this.onCloseClick, required this.adInitializer});

  @override
  State<ChoiceResultPage> createState() => _ChoiceResultPageState();
}

class _ChoiceResultPageState extends State<ChoiceResultPage> {
  List<ChoiceModel> choices = [];
  @override
  void initState() {
    widget.adInitializer.showInterstitialAd();
    choices = RandomChoicePageView.mChoicesList;
    for (var i = 0; i < choices.length; i++) {
      var element = choices[i];
      if (element.choiceName.isEmpty) {
        choices.removeAt(i);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var randomNum = Random().nextInt(choices.length);
    var element = choices.elementAt(randomNum);

    return Center(
        child: MyColumnWidget(
      onCloseClick: widget.onCloseClick,
      onSpinClick: () {
        setState(() {});
      },
      resultRow: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/kitty.png',
            width: 96,
            height: 96,
          ),
          Flexible(
            child: ItemShapeDesign(
                contentWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(element.choiceName),
                ),
                containerColor: element.choiceColor),
          ),
        ],
      ),
    ));
  }
}

class MyColumnWidget extends StatefulWidget {
  MyColumnWidget(
      {required this.onCloseClick,
      required this.resultRow,
      required this.onSpinClick});
  final Function onCloseClick, onSpinClick;
  final Widget resultRow;

  @override
  State<MyColumnWidget> createState() => _MyColumnWidgetState();
}

class _MyColumnWidgetState extends State<MyColumnWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BtnIconElement(
          onClick: widget.onCloseClick,
          background: Colors.red,
          icon: Icons.close,
          size: 32,
        ),
        widget.resultRow,
        BtnIconElement(
          onClick: widget.onSpinClick,
          background: MyColors.someOrange,
          icon: Icons.refresh,
          size: 28,
        ),
      ],
    );
  }
}

class SpinAgainRow extends StatefulWidget {
  final Function onSpinClick;
  const SpinAgainRow({required this.onSpinClick});

  @override
  State<SpinAgainRow> createState() => _SpinAgainRowState();
}

class _SpinAgainRowState extends State<SpinAgainRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSpinClick();
      },
      child: CircularContainer(
          contentColor: MyColors.someOrange,
          shadowColor: MyColors.darkOrange,
          content: const Icon(Icons.refresh)),
    );
  }
}
