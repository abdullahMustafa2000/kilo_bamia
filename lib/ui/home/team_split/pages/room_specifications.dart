// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/elements/page_model.dart';
import 'package:toast/toast.dart';

class RoomSpecifications extends StatelessWidget {
  final Function onBtnClick;
  final Function onClose;
  final GameModel gameModel;
  const RoomSpecifications(this.onBtnClick, this.gameModel,
      {required this.onClose});

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
  final Function onBtnClick;
  final GameModel gameModel;
  const InputContainer(this.onBtnClick, this.gameModel);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          getLocalization(context).nameTheSplit,
          style: GoogleFonts.k2d(
            textStyle: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
        Container(
          width: width * .4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.textFieldFillClr.withOpacity(.45),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TextField(
              controller: TextEditingController()..text = gameModel.roomName,
              onChanged: (txt) {
                gameModel.roomName = txt;
              },
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              style: const TextStyle(
                color: MyColors.lightBlack,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.titleMedium,
                hintText: getLocalization(context).splitNameHint,
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            teamsDataTextField(getLocalization(context).playersLabel,
                onPlayersTxtChange, context, gameModel.noOfPlayers),
            teamsDataTextField(getLocalization(context).teamsLabel,
                onTeamsTxtChange, context, gameModel.noOfTeams),
          ],
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        SizedBox(
          width: width * .25,
          child: ElevatedButton(
            onPressed: () {
              if (acceptedInput(context)) {
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
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        Container(
          width: MediaQuery.of(context).size.width * .16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.textFieldFillClr.withOpacity(.45),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: TextEditingController()
                  ..text = number > 0 ? number.toString() : "",
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
                  hintStyle: Theme.of(context).textTheme.titleMedium,
                  hintText: '04',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onPlayersTxtChange(String txt) {
    if (txt.isNotEmpty) {
      gameModel.noOfPlayers = int.parse(txt);
    }
  }

  void onTeamsTxtChange(String txt) {
    if (txt.isNotEmpty) {
      gameModel.noOfTeams = int.parse(txt);
    }
  }

  bool acceptedInput(BuildContext context) {
    // filled text fields,  no zero inputs,  number of players = or > number of teams
    bool accepted = false;
    if (gameModel.noOfPlayers == 0 ||
        gameModel.noOfTeams == 0 ||
        gameModel.roomName != '') {
      if (gameModel.noOfTeams != 0 && gameModel.noOfPlayers != 0) {
        if (gameModel.noOfTeams <= gameModel.noOfPlayers) {
          accepted = true;
        } else {
          showToast(
              getLocalization(context).playersLessThanTeamsErrMsg, context);
        }
      } else {
        showToast(getLocalization(context).zeroInputErrMsg, context);
      }
    } else {
      showToast(getLocalization(context).emptyFieldsErrMsg, context);
    }
    return accepted;
  }

  void showToast(String message, BuildContext context) {
    ToastContext().init(context);
    Toast.show(message,
        backgroundColor: MyColors.spinnerLightRed,
        duration: Toast.lengthShort,
        gravity: Toast.center);
  }
}
