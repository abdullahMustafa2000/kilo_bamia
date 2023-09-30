import 'dart:async';

import 'package:flutter/material.dart';

import '../../themes/colors_file.dart';
import 'circular_container.dart';

class BtnIconElement extends StatelessWidget {
  const BtnIconElement(
      {Key? key, required this.onClick,
      required this.background,
      required this.icon,
      required this.size, this.timer}) : super(key: key);
  final Function onClick;
  final Color background;
  final IconData icon;
  final double size;
  final Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          onClick();
          if (timer != null) timer!.cancel();
        },
        child: CircularContainer(
          contentColor: background,
          shadowColor: background,
          content: Icon(
            icon,
            size: size,
            color: MyColors.lightBlack.withOpacity(.86),
          ),
        ),
      ),
    );
  }
}
