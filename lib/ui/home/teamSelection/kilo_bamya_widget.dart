import 'package:flutter/material.dart';
import 'package:kilo_bamya/local_db/game_model.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/teamSelection/page_view.dart';

class DivideTeamsWidget extends StatelessWidget {
  DivideTeamsWidget({required this.onSaveBtnClick, required this.showResultWidget, this.clickedRecent});
  Function onSaveBtnClick;
  int showResultWidget;
  GameModel? clickedRecent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: MyColors.lightBlack.withOpacity(.86),
          ),
          KiloBamyaPageView(onSaveBtnClick, showResultWidget, gameModel: clickedRecent),
        ],
      ),
    );
  }
}
