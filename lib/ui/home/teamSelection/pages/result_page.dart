// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/local_db/database.dart';
import 'package:kilo_bamya/local_db/game_model.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/spinning_wheel_page.dart';
import 'package:kilo_bamya/ui/home/teamSelection/next_page_provider.dart';
import 'package:kilo_bamya/ui/home/teamSelection/page_model.dart';
import 'package:provider/provider.dart';

import '../teams_provider.dart';

class ResultPage extends StatefulWidget {
  Function onSaveBtnClick;
  int showResultWidget;

  Function onClose;
  Function(int) onBack;
  Function moveToPrev;

  GameModel? teams;
  ResultPage(
      {Key? key,
      required this.onSaveBtnClick,
      required this.showResultWidget,
      required this.moveToPrev,
      required this.onClose,
      required this.onBack,
      this.teams})
      : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  GamesDatabase database = GamesDatabase.instance;
  var fromRecent = false;
  @override
  void initState() {
    super.initState();
    fromPref = widget.showResultWidget;
    fromRecent = fromPref == 1;
  }

  late int fromPref;
  late TeamProvider provider;
  late NextPageProvider nextPageProvider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<TeamProvider>(context);
    nextPageProvider = NextPageProvider();
    return MyKiloBamayaPageModel(
      showBackBtn: false,
      onClose: () {
        widget.onClose();
      },
      onPrev: () {
        widget.onBack(fromPref);
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
                  /// save button
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
        fromPref = -1;
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
          'Save',
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
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 47,
      height: 47,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(180.0)),
        boxShadow: [
          BoxShadow(
              blurRadius: 22,
              color: MyColors.darkOrange.withOpacity(.25),
              spreadRadius: 12)
        ],
      ),
      child: SizedBox(
        width: 46,
        height: 46,
        child: InkWell(
          onTap: () {
            setState(() {
              fromPref = 0;
            });
          },
          child: CircularContainer(
              contentColor: MyColors.someOrange,
              shadowColor: MyColors.darkOrange,
              content: const Icon(Icons.refresh)),
        ),
      ),
    );
  }

  void saveData() {
    if (fromRecent) {
      database.update(widget.teams!);
    } else {
      database.create(widget.teams!);
    }
    provider.newTeamDivided();
  }

  Future<List<String>> getPreferences() async {
    if (fromPref == 1) {
      provider.players = widget.teams!.players!;
      return widget.teams!.result!;
    } else if (fromPref == 0) {
      return provider.splitPlayers(widget.teams?.players ?? provider.players);
    } else {
      fromPref = widget.showResultWidget;
      return [];
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
