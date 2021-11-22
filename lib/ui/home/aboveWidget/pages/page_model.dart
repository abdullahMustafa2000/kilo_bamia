// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

class MyKiloBamayaPageModel extends StatelessWidget {

  Widget content;

  MyKiloBamayaPageModel({required this.content});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Image.asset(
          'assets/images/spinning_wheel.png',
          width: width * .7,
          height: height * .2,
        ),
        MyInputResultBox(content),
      ],
    );
  }
}

class MyInputResultBox extends StatelessWidget {
  Widget content;

  MyInputResultBox(this.content);

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
      child: content,
    );
  }
}

