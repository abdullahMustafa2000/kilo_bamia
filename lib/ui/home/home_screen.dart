import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/btm_nav_provider.dart';
import 'package:kilo_bamya/ui/home/fragments/coin_widget.dart';
import 'package:kilo_bamya/ui/home/randomChoice/random_choice_screen.dart';
import 'package:kilo_bamya/ui/home/sideMenu/side_menu_widget.dart';
import 'package:kilo_bamya/ui/home/fragments/wheel_widget.dart';
import 'package:provider/provider.dart';
import 'team_split//split_teams_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeClicksProvider provider;
  bool callRandomChoiceWidget = false;
  late AdInitializer _adInitializer;
  @override
  void initState() {
    super.initState();
    _adInitializer = AdInitializer();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<HomeClicksProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: const MyDrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              child: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Transform.flip(
                        flipX: isRTL(context),
                        child: Image.asset('assets/images/menu_ic.png')),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                );
              }),
            ),
            Center(
              child: Text(
                getLocalization(context).appName,
                textAlign: TextAlign.center,
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w900)),
              ),
            ),
            Visibility(
              visible: true,
              child: Align(
                child: Builder(builder: (context) {
                  return Image.asset(
                    'assets/images/menu_ic.png',
                    color: MyColors.darkBlue,
                  );
                }),
              ),
            )
          ],
        ),
        backgroundColor: MyColors.darkBlue,
      ),
      body: stackOrHome(),
      bottomNavigationBar: CustomBottomNav(!aboveWidgetIsVisible),
    );
  }

  bool aboveWidgetIsVisible = false;
  bool callResultWidget = false;
  GameModel? clickedRecent;
  // if random choice is 1 then open randomChoice pageView
  void showAboveWidgetListener(
      {required bool openSplitResult,
      required bool openRandomChoice,
      GameModel? gameModel}) {
    if (openRandomChoice) {
      callRandomChoiceWidget = true;
    } else {
      callResultWidget = openSplitResult;
      clickedRecent = gameModel;
    }
    aboveWidgetIsVisible = true;
    setState(() {});
  }

  void onSaveBtnClick() {
    setState(() {
      aboveWidgetIsVisible = !aboveWidgetIsVisible;
      callResultWidget = false;
      callRandomChoiceWidget = false;
    });
  }

  Widget stackOrHome() {
    return Stack(
      children: [
        provider.btmIndex == 0
            ? WheelWidget(aboveWidgetCall: showAboveWidgetListener)
            : CoinWidget(),
        Offstage(
          offstage: !aboveWidgetIsVisible,
          child: callRandomChoiceWidget
              ? RandomChoiceWidget(
                  onClickClose: onSaveBtnClick,
                  adInitializer: _adInitializer,
                )
              : DivideTeamsWidget(
                  onSaveBtnClick: onSaveBtnClick,
                  showResultWidget: callResultWidget,
                  splitRoom: clickedRecent ?? GameModel.init(),
                  adInitializer: _adInitializer,
                ),
        )
      ],
    );
  }
}

class CustomBottomNav extends StatefulWidget {
  final bool isAboveWidgetVisible;

  const CustomBottomNav(this.isAboveWidgetVisible, {Key? key})
      : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  late HomeClicksProvider provider;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<HomeClicksProvider>(context);
    return Stack(children: [
      Container(
        height: 62,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            color: MyColors.lightBlack,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
              )
            ]),
        child: Row(
          children: [
            Expanded(
              child: wheelOrCoinWidget(0, getLocalization(context).wheelTabName,
                  provider.btmIndex == 0 ? MyColors.darkBlue : MyColors.white),
            ),
            Container(
              width: 4,
              decoration: BoxDecoration(
                  color: MyColors.blueShadowClr,
                  borderRadius: BorderRadius.circular(6)),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            ),
            Expanded(
              child: wheelOrCoinWidget(
                  1,
                  getLocalization(context).coinTabName,
                  provider.btmIndex == 1
                      ? MyColors.darkOrange
                      : MyColors.white),
            ),
          ],
        ),
      ),
      Offstage(
        offstage: widget.isAboveWidgetVisible,
        child: Container(
          height: 62,
          color: MyColors.lightBlack.withOpacity(.89),
        ),
      ),
    ]);
  }

  //index = 0 => means wheel
  Widget wheelOrCoinWidget(int index, String title, Color color) {
    return InkWell(
      onTap: () {
        provider.updateBtnNavIndex(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 8,
            width: 50,
            decoration: BoxDecoration(
                color: color == MyColors.white ? MyColors.lightBlack : color,
                borderRadius: BorderRadius.circular(6)),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
