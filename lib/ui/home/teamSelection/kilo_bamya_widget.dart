import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/teamSelection/page_view.dart';

class DivideTeamsWidget extends StatelessWidget {
  DivideTeamsWidget({required this.onSaveBtnClick, required this.showResultWidget});
  Function onSaveBtnClick;
  int showResultWidget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColors.lightBlack.withOpacity(.86),
        ),
        KiloBamyaPageView(onSaveBtnClick, showResultWidget),
      ],
    );
  }
}
