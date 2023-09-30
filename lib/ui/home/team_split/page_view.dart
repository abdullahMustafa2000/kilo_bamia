// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/local_db/game_model.dart';
import 'package:kilo_bamya/models/choice_class_model.dart';
import 'package:kilo_bamya/ui/elements/loading_wheel_screen.dart';
import 'package:kilo_bamya/ui/home/team_split/next_page_provider.dart';
import 'package:kilo_bamya/ui/home/team_split/pages/result_page.dart';
import 'package:kilo_bamya/ui/home/team_split/pages/room_specifications.dart';
import 'pages/take_players_page.dart';

class KiloBamyaPageView extends StatefulWidget {
  Function onSaveBtnClick;
  int showResultWidget;
  GameModel? gameModel;
  KiloBamyaPageView(this.onSaveBtnClick, this.showResultWidget,
      {this.gameModel});

  @override
  State<KiloBamyaPageView> createState() => _KiloBamyaPageViewState();
}

class _KiloBamyaPageViewState extends State<KiloBamyaPageView> {
  final _controller = PageController();
  late NextPageProvider provider;
  late AdInitializer _adInitializer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _adInitializer = AdInitializer();
    provider = NextPageProvider();
    if (widget.showResultWidget == 0) {
      _controller.jumpToPage(0);
      provider.currentPage = 0;
    } else if (widget.showResultWidget == 1) {
      _controller.jumpToPage(4);
      provider.currentPage = 4;
    }
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RoomSpecifications(onMoveToNext, widget.gameModel,
              onClose: onSaveBtnClick),
          RoomPlayers(
              onBtnClick: onMoveToNext,
              onClose: onSaveBtnClick,
              onPrev: onMoveToPrev,
              gameModel: widget.gameModel),
          LoadingResultScreen(
            onMoveToNext: onMoveToNext,
            onBackClick: onMoveToPrev,
            onCloseClick: onSaveBtnClick,
          ),
          ResultPage(
            adInitializer: _adInitializer,
            onSaveBtnClick: onSaveBtnClick,
            moveToPrev: onMoveToPrev,
            onClose: onSaveBtnClick,
            showResultWidget: widget.showResultWidget,
            onBack: onBackBtnPressed,
            teams: widget.gameModel,
          ),
        ],
      ),
    );
  }

  void onBackBtnPressed(int backCode) {
    _controller.animateToPage(provider.moveToInitPage(),
        duration: const Duration(milliseconds: 400), curve: Curves.bounceOut);
  }

  void onMoveToNext({List<ChoiceModel>? choices}) {
    _controller.animateToPage(provider.moveToNextPage(),
        duration: const Duration(milliseconds: 400), curve: Curves.bounceOut);
  }

  void onMoveToPrev() {
    _controller.animateToPage(provider.moveToPrevPage(),
        duration: const Duration(milliseconds: 400), curve: Curves.bounceIn);
  }

  void onSaveBtnClick() {
    widget.onSaveBtnClick();
  }
}
