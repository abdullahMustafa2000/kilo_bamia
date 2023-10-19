import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/elements/spinning_wheel.dart';
import '../../../../models/choice_class_model.dart';
import 'circular_container.dart';
import 'icon_btn.dart';

class LoadingResultScreen extends StatelessWidget {
   LoadingResultScreen(
      {Key? key,
      required this.onCloseClick,
      required this.onBackClick,
      required this.onMoveToNext})
      : super(key: key);
  final Function onBackClick, onCloseClick;
  final void Function({List<ChoiceModel>? choices}) onMoveToNext;
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    timer = Timer(const Duration(seconds: 2), () {
      onMoveToNext(choices: []);
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BtnIconElement(
          onClick: onCloseClick,
          background: Colors.red,
          icon: Icons.close,
          size: 40,
          timer: timer,
        ),
        SpinningWheel(),
        BackRow(onBackClick: onBackClick, timer: timer),
      ],
    );
  }
}

class BackRow extends StatelessWidget {
  const BackRow({Key? key, required this.onBackClick, required this.timer})
      : super(key: key);
  final Function onBackClick;
  final Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          onBackClick();
          timer?.cancel();
        },
        child: CircularContainer(
          contentColor: Colors.transparent,
          shadowColor: MyColors.darkBlue.withOpacity(.5),
          content: Image.asset(
            'assets/images/back_btn.png',
            width: 65,
            height: 65,
          ),
        ),
      ),
    );
  }
}
