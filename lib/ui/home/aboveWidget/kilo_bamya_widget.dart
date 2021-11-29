import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/page_view.dart';

class KioBamayView extends StatelessWidget {
  KioBamayView(this.onSaveBtnClick);
  Function onSaveBtnClick;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColors.lightBlack.withOpacity(.86),
        ),
        KiloBamyaPageView(onSaveBtnClick),
      ],
    );
  }
}
