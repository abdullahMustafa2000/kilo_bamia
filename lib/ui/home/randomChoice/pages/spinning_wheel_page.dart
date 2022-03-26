import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

import '../../../../moduls/choice_class_model.dart';

class AnimationPage extends StatelessWidget {
  AnimationPage(
      {required this.onCloseClick,
      required this.onBackClick,
      required this.onMoveToNext});
  Function onBackClick, onCloseClick;
  Function(List<ChoiceModel>) onMoveToNext;
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      onMoveToNext([]);
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CloseRow(onCloseClick: onCloseClick),
        AnimatedWheelRow(),
        BackRow(onBackClick: onBackClick),
      ],
    );
  }
}

class AnimatedWheelRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: MediaQuery.of(context).size.height * .3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/spinning_wheel.png'),
            Image.asset(
              'assets/images/kitty.png',
              width: 96,
              height: 96,
            ),
          ],
        ),
      ),
    );
  }
}

class CircularContainer extends StatelessWidget {
  Color contentColor, shadowColor;
  Widget content;
  CircularContainer(
      {required this.contentColor,
      required this.shadowColor,
      required this.content});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(180),
          color: contentColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 0,
              blurRadius: 30,
              offset: const Offset(0, 0),
            )
          ]),
      child: Center(
        child: content,
      ),
    );
  }
}

class CloseRow extends StatelessWidget {
  CloseRow({required this.onCloseClick});
  Function onCloseClick;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: InkWell(
        onTap: () {
          onCloseClick();
        },
        child: CircularContainer(
          contentColor: Colors.red,
          shadowColor: Colors.red,
          content: Icon(
            Icons.close,
            size: 40,
            color: MyColors.lightBlack.withOpacity(.86),
          ),
        ),
      ),
    );
  }
}

class BackRow extends StatelessWidget {
  BackRow({required this.onBackClick});
  Function onBackClick;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: InkWell(
        onTap: () {
          onBackClick();
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
