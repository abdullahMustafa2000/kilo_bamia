import 'package:flutter/material.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/team_split/page_view.dart';

class DivideTeamsWidget extends StatelessWidget {
  const DivideTeamsWidget(
      {Key? key, required this.onSaveBtnClick,
      required this.showResultWidget,
      required this.splitRoom}) : super(key: key);
  final Function onSaveBtnClick;
  final bool showResultWidget;
  final GameModel? splitRoom;
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
          KiloBamyaPageView(onSaveBtnClick, showResultWidget,
              splitRoom: splitRoom),
        ],
      ),
    );
  }
}
