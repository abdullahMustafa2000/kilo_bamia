import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kilo_bamya/moduls/room_module.dart';
import 'package:kilo_bamya/shared_pereferences/saved_game.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
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

  ResultPage(
      {required this.onSaveBtnClick,
      required this.showResultWidget,
      required this.moveToPrev,
      required this.onClose,
      required this.onBack});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    fromPref = widget.showResultWidget;
  }

  late int fromPref;
  late TeamProvider provider;
  late NextPageProvider nextPageProvider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<TeamProvider>(context);
    nextPageProvider = NextPageProvider();
    return MyKiloBamayaPageModel(
      onClose: widget.onClose,
      onPrev: () {
        widget.onBack(fromPref);
      },
      content: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          children: [
            Container(
              child: Text(
                'Result',
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
    print(list.first);
    return ListView.builder(
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
      child: RaisedButton(
        onPressed: () {
          setState(() {
            fromPref = 0;
          });
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(180.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      MyColors.lightOrange.withOpacity(.1),
                      MyColors.darkOrange.withOpacity(.3),
                    ]),
                borderRadius: const BorderRadius.all(Radius.circular(80.0))),
            constraints: const BoxConstraints(
                minWidth: 88.0,
                minHeight: 36.0), // min sizes for Material buttons
            alignment: Alignment.center,
            child: Text('Spin Again',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption),
          ),
        ),
      ),
    );
  }

  void saveData() {
    StorageManager.saveData(RoomModule.room_name_prefKey, provider.roomName);
    StorageManager.saveData(
        RoomModule.num_of_teams_prefKey, provider.noOfTeams);
    StorageManager.saveData(
        RoomModule.num_of_players_prefKey, provider.noOfPlayers);
    String date = ('${DateTime.now().month} / ${DateTime.now().day}');
    StorageManager.saveData(RoomModule.create_date_prefKey, date);
    StorageManager.saveData(RoomModule.room_teams_list_prefKey, provider.teams);
    StorageManager.saveData(
        RoomModule.room_players_names_prefKey, provider.players);
    provider.newTeamDivided();
  }

  Future<List<String>> getPreferences() async {
    print(fromPref);
    if (fromPref == 1) {
      provider.players = await StorageManager.readStringList(
          RoomModule.room_players_names_prefKey);
      return await StorageManager.readStringList(
          RoomModule.room_teams_list_prefKey);
    } else if (fromPref == 0) {
      return provider.dividePlayers();
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
      {required this.teamMembers,
      required this.teamColor,
      required this.teamIndex});

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
