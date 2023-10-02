// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/local_db/shared_pref.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/team_split/next_page_provider.dart';
import 'package:kilo_bamya/ui/elements/page_model.dart';
import 'package:provider/provider.dart';
import '../../../elements/icon_btn.dart';
import '../teams_provider.dart';

class ResultPage extends StatefulWidget {
  Function onSaveBtnClick;
  bool showResultWidget;

  Function onClose;
  Function onBack;
  Function moveToPrev;
  final AdInitializer adInitializer;
  GameModel gameModel;
  ResultPage(
      {Key? key,
      required this.onSaveBtnClick,
      required this.showResultWidget,
      required this.moveToPrev,
      required this.onClose,
      required this.onBack,
      required this.adInitializer,
      required this.gameModel})
      : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    fromPref = widget.showResultWidget;
    fromRecent = fromPref ?? false;
    widget.adInitializer.showInterstitialAd();
  }

  var fromRecent = false;
  late bool? fromPref;
  late TeamProvider provider;
  late NextPageProvider nextPageProvider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<TeamProvider>(context);
    nextPageProvider = NextPageProvider();
    return MyKiloBamayaPageModel(
      showBackBtn: true,
      onClose: () {
        widget.onClose();
      },
      onPrev: () {
        widget.onBack();
      },
      content: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          children: [
            Container(
              child: Text(
                getLocalization(context).splitResult,
                style: Theme.of(context).textTheme.headline4,
              ),
              margin: const EdgeInsets.all(8),
            ),
            Expanded(
              child: FutureBuilder(
                future: getPreferences(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      provider.teams = snapshot.data as List<String>;
                      widget.gameModel.teams = provider.teams;
                      return resultListWidget(snapshot.data as List<String>);
                    } else {
                      return const Center(child: Text('Unknown error accrued'));
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  saveBtn(),
                  reSpinBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  var colorsArr = [
    MyColors.darkBlue,
    MyColors.spinnerLightRed,
    MyColors.darkOrange,
    MyColors.darkYellow,
    MyColors.bottomGradient,
  ];

  Widget saveBtn() {
    return InkWell(
      onTap: () {
        saveData();
        fromPref = null;
        widget.onSaveBtnClick();
      },
      child: Container(
        width: 47,
        height: 47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(180),
          color: MyColors.darkWhite,
        ),
        child: Center(
            child: Text(
          getLocalization(context).saveBtn,
          style: Theme.of(context).textTheme.caption,
        )),
        margin: const EdgeInsets.only(right: 10),
      ),
    );
  }

  Widget resultListWidget(List<String> list) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return TeamDesign(
            teamMembers: list[index].split(','),
            teamColor: colorsArr[index],
            teamIndex: index);
      },
    );
  }

  Widget reSpinBtn() {
    return BtnIconElement(
      onClick: () {
        setState(() {
          fromPref = false;
        });
      },
      background: MyColors.someOrange,
      icon: Icons.refresh,
      size: 28,
    );
  }

  void saveData() {
    if (fromRecent) {
      teamsDatabase().child(widget.gameModel.id!).update(widget.gameModel.toJson());
    } else {
      MySharedPref.getNewRoomId().then((value) => {
            widget.gameModel.id = value,
            teamsDatabase().child(value).set(widget.gameModel.toJson())
          });
    }
  }

  Future<List<String>> getPreferences() async {
    if (fromPref == null) {
      fromPref = widget.showResultWidget;
      return [];
    }
    if (fromPref!) {
      provider.players = widget.gameModel.players;
      return widget.gameModel.teams;
    } else {
      return provider.splitPlayers(widget.gameModel);
    }
  }
}

class TeamDesign extends StatelessWidget {
  List<String> teamMembers = [];
  Color teamColor;
  int teamIndex;

  TeamDesign(
      {Key? key,
      required this.teamMembers,
      required this.teamColor,
      required this.teamIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Text(
                'Team ${teamIndex + 1}',
                style: TextStyle(color: teamColor, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(bottom: 8),
            ),

            /// team list
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: teamMembers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(2),
                      child: Text(
                        teamMembers[index],
                        style: TextStyle(
                            fontSize: 14, color: teamColor.withOpacity(.5)),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
