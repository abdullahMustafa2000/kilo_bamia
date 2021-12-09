// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kilo_bamya/moduls/room_module.dart';
import 'package:kilo_bamya/shared_pereferences/saved_game.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/page_model.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/teams_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomSpecifications extends StatelessWidget {
  Function onBtnClick;
  Function onClose;

  RoomSpecifications(this.onBtnClick, {required this.onClose});

  @override
  Widget build(BuildContext context) {
    return MyKiloBamayaPageModel(
        content: InputContainer(onBtnClick),
      onPrev: () {},
      onClose: onClose,
    );
  }
}

class InputContainer extends StatelessWidget {
  Function onBtnClick;

  InputContainer(this.onBtnClick);

  String? roomNameEt;
  String? teamsNumEt;
  static String? playersNumEt;
  late TeamProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<TeamProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Room name :',
          style: Theme.of(context).textTheme.headline4,
        ),
        Container(
          width: width * .4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.textFieldFillClr.withOpacity(.45),
          ),
          child: TextField(
            onChanged: (txt) {
              roomNameEt = txt;
              provider.roomName = txt;
            },
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              color: MyColors.lightBlack,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: Theme.of(context).textTheme.subtitle1,
              hintText: 'Enter name',
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            teamsDataTextField(
                'Number of players :', onPlayersTxtChange, context),
            teamsDataTextField('Number of teams :', onTeamsTxtChange, context),
          ],
        ),
        SizedBox(
          width: width * .25,
          child: RaisedButton(
            onPressed: () {
              onBtnClick();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      MyColors.lightOrange.withOpacity(.1),
                      MyColors.darkOrange.withOpacity(.3),
                    ]),
                borderRadius: const BorderRadius.all(Radius.circular(80.0)),
              ),
              child: Container(
                constraints: const BoxConstraints(
                    minWidth: 88.0,
                    minHeight: 36.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: Text(
                  'Create',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: MyColors.lightBlack.withOpacity(0.9)),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget teamsDataTextField(
      String label, Function onTxtChange, BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.caption,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.textFieldFillClr.withOpacity(.45),
          ),
          child: TextField(
            onChanged: (txt) {
              onTxtChange(txt);
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: Theme.of(context).textTheme.subtitle1,
              hintText: '04',
            ),
          ),
        ),
      ],
    );
  }

  void onPlayersTxtChange(String txt) {
    playersNumEt = txt;
    provider.noOfPlayers = int.parse(txt);
  }

  void onTeamsTxtChange(String txt) {
    teamsNumEt = txt;
    provider.noOfTeams = int.parse(txt);
  }
}
