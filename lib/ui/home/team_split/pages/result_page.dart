// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:kilo_bamya/ads/ad_initializer.dart';
import 'package:kilo_bamya/local_db/shared_pref.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
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
  bool backClicked = false;

  @override
  void initState() {
    super.initState();
    widget.adInitializer.showInterstitialAd();
  }
  @override
  Widget build(BuildContext context) {
    return MyKiloBamayaPageModel(
      showBackBtn: true,
      onClose: () {
        widget.gameModel.firstSplit = null;
        widget.onClose();
      },
      onPrev: () {
        backClicked = true;
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
              child: TeamsResult(
                gameModel: widget.gameModel,
                fromDB: widget.showResultWidget && !backClicked,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  saveBtn(context),
                  const SizedBox(
                    width: 8,
                  ),
                  reSpinBtn(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget saveBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.gameModel.firstSplit = null;
        saveData();
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

  Widget reSpinBtn(BuildContext context) {
    return BtnIconElement(
      onClick: () {
        widget.gameModel.firstSplit = false;
        Provider.of<TeamProvider>(context, listen: false)
            .changeResultProvider(false);
      },
      background: MyColors.someOrange,
      icon: Icons.refresh,
      size: 28,
    );
  }

  void saveData() async {
    if (widget.gameModel.id != null) {
      await widget.gameModel.save();
    } else {
      MySharedPref.getNewRoomId().then((id) => {
            widget.gameModel.id = id,
            teamsHiveDB().put(id, widget.gameModel),
          });
    }
  }
}

class TeamsResult extends StatefulWidget {
  GameModel gameModel;
  bool fromDB;
  TeamsResult({required this.gameModel, required this.fromDB});
  @override
  State<TeamsResult> createState() => _TeamsResultState();
}

class _TeamsResultState extends State<TeamsResult> {
  late TeamProvider _provider;
  @override
  void initState() {
    widget.gameModel.firstSplit = widget.fromDB;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<TeamProvider>(context);
    return FutureBuilder<List<String>>(
      future: getPreferences(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            widget.gameModel.teams = snapshot.data!;
            return resultListWidget(snapshot.data!);
          } else {
            return Center(child: Text(getLocalization(context).unknownErr));
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<String>> getPreferences() async {
    bool? tst = _provider.fromDB;
    if (widget.gameModel.firstSplit == null || widget.gameModel.firstSplit!) {
      return widget.gameModel.teams;
    } else {
      return TeamProvider.splitPlayers(widget.gameModel);
    }
  }

  Widget resultListWidget(List<String> list) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        int clrsLength = MyColors.teamsColorsArray.length;
        return TeamDesign(
            teamMembers: list[index].split(','),
            teamColor: MyColors.teamsColorsArray[
                index == clrsLength ? index -= clrsLength : index],
            teamIndex: index);
      },
    );
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
                '${getLocalization(context).teamTitle} ${teamIndex + 1}',
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
                            fontSize: 14, color: teamColor.withOpacity(.7)),
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
