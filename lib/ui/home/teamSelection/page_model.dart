// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

class MyKiloBamayaPageModel extends StatelessWidget {
  Widget content;
  Function onClose;
  Function onPrev;
  bool showBackBtn;
  MyKiloBamayaPageModel({required this.content, required this.onClose, required this.onPrev, required this.showBackBtn});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(children: [
            Image.asset(
              'assets/images/spinning_wheel.png',
              width: width * .5,
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/kitty.png',
                width: width * .3,
              ),
            )
          ],
            alignment: Alignment.center,
          ),
          MyInputResultBox(content, onClose, onPrev, showBackBtn),
        ],
      ),
    );
  }
}

class MyInputResultBox extends StatelessWidget {
  Widget content;
  Function onClose;
  Function onPrev;
  bool showBackBtn;

  MyInputResultBox(this.content, this.onClose, this.onPrev, this.showBackBtn);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyColors.homeBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                  child: backBtn(),
                visible: showBackBtn,
              ),
              closeBtn(),
            ],
          ),
          content,
        ],
      ),
    );
  }

  Widget backBtn() {
    return InkWell(
      onTap: () {
        onPrev();
      },
      child: const SizedBox(
        width: 37,
        height: 37,
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: MyColors.darkBlue,
        ),
      ),
    );
  }

  Widget closeBtn() {
    return InkWell(
      onTap: () {
        onClose();
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.spinnerLightRed,
          borderRadius: BorderRadius.circular(180),
        ),
        width: 25,
        height: 25,
        child: const Icon(
          Icons.close,
          size: 22,
          color: MyColors.homeBg,
        ),
      ),
    );
  }
}
