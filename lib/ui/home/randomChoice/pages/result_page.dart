import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/moduls/choice_class_model.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/enter_choices_page.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/spinning_wheel_page.dart';
import 'package:kilo_bamya/ui/home/randomChoice/random_choice_pageview.dart';

class ChoiceResultPage extends StatefulWidget {
  late Function onCloseClick;
  ChoiceResultPage({required this.onCloseClick});

  @override
  State<ChoiceResultPage> createState() => _ChoiceResultPageState();
}

class _ChoiceResultPageState extends State<ChoiceResultPage> {
  List<ChoiceModel> choices = [];
  @override
  void initState() {
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
    var element =
        choices.elementAt(Random().nextInt(choices.length - 1));
    return Center(
      child: MyColumnWidget(
        onCloseClick: widget.onCloseClick,
        onSpinClick: () {
          setState(() {
          });
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
      )
    );
  }
}

class MyColumnWidget extends StatefulWidget {
  MyColumnWidget({required this.onCloseClick, required this.resultRow, required this.onSpinClick});
  Function onCloseClick, onSpinClick;
  Widget resultRow;

  @override
  State<MyColumnWidget> createState() => _MyColumnWidgetState();
}

class _MyColumnWidgetState extends State<MyColumnWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CloseRow(onCloseClick: widget.onCloseClick),
        widget.resultRow,
        SpinAgainRow(onSpinClick: widget.onSpinClick,),
      ],
    );
  }
}

class SpinAgainRow extends StatelessWidget {
  Function onSpinClick;
  SpinAgainRow({required this.onSpinClick});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        onSpinClick();
      },
      child: CircularContainer(
          contentColor: MyColors.spinnerOrange,
          shadowColor: MyColors.spinnerLightRed,
          content: const Text(
            'Spin Again',
            style: TextStyle(
              color: MyColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
