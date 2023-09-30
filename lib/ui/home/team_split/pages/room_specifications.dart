// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/local_db/game_model.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/elements/page_model.dart';
import 'package:kilo_bamya/ui/home/team_split/teams_provider.dart';
import 'package:provider/provider.dart';

class RoomSpecifications extends StatelessWidget {
  Function onBtnClick;
  Function onClose;
  GameModel? gameModel;
  RoomSpecifications(this.onBtnClick, this.gameModel, {required this.onClose});

  @override
  Widget build(BuildContext context) {
    return MyKiloBamayaPageModel(
      showBackBtn: false,
      content: InputContainer(onBtnClick, gameModel),
      onPrev: () {},
      onClose: onClose,
    );
  }
}

class InputContainer extends StatelessWidget {
  Function onBtnClick;
  GameModel? gameModel;
  InputContainer(this.onBtnClick, this.gameModel);

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
          getLocalization(context).nameTheSplit,
          style: GoogleFonts.k2d(
            textStyle: Theme.of(context).textTheme.headline4,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
        Container(
          width: width * .4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.textFieldFillClr.withOpacity(.45),
          ),
          child: TextField(
            controller: TextEditingController()..text = "",
            onChanged: (txt) {
              roomNameEt = txt;
              provider.roomName = txt;
            },
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.done,
            style: const TextStyle(
              color: MyColors.lightBlack,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: Theme.of(context).textTheme.subtitle1,
              hintText: getLocalization(context).splitNameHint,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            teamsDataTextField(getLocalization(context).numberOfParticipants,
                onPlayersTxtChange, context, gameModel?.noOfPlayers ?? 0),
            teamsDataTextField(getLocalization(context).numberOfTeams,
                onTeamsTxtChange, context, gameModel?.noOfTeams ?? 0),
          ],
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        SizedBox(
          width: width * .25,
          child: ElevatedButton(
            onPressed: () {
              if (acceptedInput()) {
                onBtnClick();
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              backgroundColor: MaterialStateProperty.all(MyColors.someOrange),
            ),
            child: Text(
              getLocalization(context).createSplit,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: MyColors.lightBlack.withOpacity(0.9)),
            ),
          ),
        ),
      ],
    );
  }

  Widget teamsDataTextField(
      String label, Function onTxtChange, BuildContext context, int number) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.caption,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        Container(
          width: MediaQuery.of(context).size.width * .16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.textFieldFillClr.withOpacity(.45),
          ),
          child: TextField(
            controller: TextEditingController()..text = number.toString(),
            onChanged: (txt) {
              onTxtChange(txt);
            },
            style: const TextStyle(color: Colors.black),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            cursorColor: MyColors.spinnerLightRed,
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
    if (txt.isNotEmpty) {
      playersNumEt = txt;
      provider.noOfPlayers = int.parse(txt);
    }
  }

  void onTeamsTxtChange(String txt) {
    if (txt.isNotEmpty) {
      teamsNumEt = txt;
      provider.noOfTeams = int.parse(txt);
    }
  }

  bool acceptedInput() {
    // filled text fields,  no zero inputs,  number of players = or > number of teams
    bool accepted = false;
    if (teamsNumEt != null && playersNumEt != null && roomNameEt != null) {
      if (int.parse(teamsNumEt!) != 0 && int.parse(playersNumEt!) != 0) {
        if (int.parse(teamsNumEt!) <= int.parse(playersNumEt!)) {
          accepted = true;
        } else {
          showToast('Number of players should be greater');
        }
      } else {
        showToast('Zero is not accepted');
      }
    } else {
      showToast('Please fill all fields');
    }
    return accepted;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: MyColors.spinnerLightRed,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.CENTER);
  }
}
