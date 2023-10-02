// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/models/choice_class_model.dart';
import 'package:kilo_bamya/ui/elements/loading_wheel_screen.dart';
import 'package:kilo_bamya/ui/home/team_split/next_page_provider.dart';
import 'package:kilo_bamya/ui/home/team_split/pages/result_page.dart';
import 'package:kilo_bamya/ui/home/team_split/pages/room_specifications.dart';
import 'pages/take_players_page.dart';

class KiloBamyaPageView extends StatefulWidget {
  Function onSaveBtnClick;
  bool showResultWidget;
  GameModel splitRoom;
  KiloBamyaPageView(
      {required this.splitRoom,
      required this.onSaveBtnClick,
      required this.showResultWidget});

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
    _adInitializer = AdInitializer();
    provider = NextPageProvider();
  }

  @override
  Widget build(BuildContext context) {
    initPage();
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RoomSpecifications(onMoveToNext, widget.splitRoom,
              onClose: onSaveBtnClick),
          RoomPlayers(
              onBtnClick: onMoveToNext,
              onClose: onSaveBtnClick,
              onPrev: onMoveToPrev,
              gameModel: widget.splitRoom),
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
            gameModel: widget.splitRoom,
          ),
        ],
      ),
    );
  }

  void onBackBtnPressed() {
    moveToPage(provider.moveToInitPage());
  }

  void onMoveToNext({List<ChoiceModel>? choices}) {
    moveToPage(provider.moveToNextPage());
  }

  void onMoveToPrev() {
    moveToPage(provider.moveToPrevPage());
  }

  void moveToPage(int pageIndex) {
    _controller.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  void onSaveBtnClick() {
    widget.onSaveBtnClick();
  }

  void initPage() {
    if (_controller.hasClients) {
      if (widget.showResultWidget) {
        _controller.jumpToPage(4);
        provider.currentPage = 4;
      } else {
        _controller.jumpToPage(0);
        provider.currentPage = 0;
      }
    }
  }
}
