// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/next_page_provider.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/pages/loading_room_page.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/pages/result_page.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/pages/room_specifications.dart';
import 'package:provider/provider.dart';

import 'pages/take_players_page.dart';

class KiloBamyaPageView extends StatefulWidget {
  @override
  State<KiloBamyaPageView> createState() => _KiloBamyaPageViewState();
}

class _KiloBamyaPageViewState extends State<KiloBamyaPageView> {
  final _controller = PageController();

  late NextPageProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.all(42),
      child: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RoomSpecifications(onMoveToNext),
          LoadingRoomWidget(onLoadingEnd: onMoveToNext,),
          RoomPlayers(onBtnClick: onMoveToNext,),
          ResultPage(),
          /*WheelPage(),*/
        ],
      ),
    );
  }

  onMoveToNext() {
    _controller.animateToPage(provider.moveToNextPage(),
        duration: const Duration(milliseconds: 400), curve: Curves.bounceOut);
  }
}
