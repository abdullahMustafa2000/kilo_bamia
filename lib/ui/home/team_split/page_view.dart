// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/models/choice_class_model.dart';
import 'package:kilo_bamya/ui/elements/loading_wheel_screen.dart';
import 'package:kilo_bamya/ui/home/team_split/pages/result_page.dart';
import 'package:kilo_bamya/ui/home/team_split/pages/room_specifications.dart';
import 'pages/take_players_page.dart';

class KiloBamyaPageView extends StatelessWidget {
  Function onSaveBtnClick;
  bool showResultWidget;
  GameModel splitRoom;
  AdInitializer adInitializer;
  KiloBamyaPageView(
      {required this.splitRoom,
        required this.onSaveBtnClick,
        required this.showResultWidget, required this.adInitializer});
  final _controller = PageController();
  int curPage = 0;

  @override
  Widget build(BuildContext context) {
    initPage();
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RoomSpecifications(onMoveToNext, splitRoom,
              onClose: onSaveBtnClick),
          RoomPlayers(
              onBtnClick: onMoveToNext,
              onClose: onSaveBtnClick,
              onPrev: onMoveToPrev,
              gameModel: splitRoom),
          LoadingResultScreen(
            onMoveToNext: onMoveToNext,
            onBackClick: onMoveToPrev,
            onCloseClick: onSaveBtnClick,
          ),
          ResultPage(
            adInitializer: adInitializer,
            onSaveBtnClick: onSaveBtnClick,
            moveToPrev: onMoveToPrev,
            onClose: onSaveBtnClick,
            showResultWidget: showResultWidget,
            onBack: onBackBtnPressed,
            gameModel: splitRoom,
          ),
        ],
      ),
    );
  }

  void onBackBtnPressed() {
    moveToPage(curPage = 0);
  }

  void onMoveToNext({List<ChoiceModel>? choices}) {
    moveToPage(++curPage);
  }

  void onMoveToPrev() {
    moveToPage(--curPage);
  }

  void moveToPage(int pageIndex) {
    _controller.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  void initPage() {
    if (_controller.hasClients) {
      if (showResultWidget) {
        _controller.jumpToPage(4);
        curPage = 4;
      } else {
        _controller.jumpToPage(0);
        curPage = 0;
      }
    }
  }
}
