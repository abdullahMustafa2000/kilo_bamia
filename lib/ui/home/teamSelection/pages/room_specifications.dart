// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/teamSelection/page_model.dart';
import 'package:kilo_bamya/ui/home/teamSelection/teams_provider.dart';
import 'package:provider/provider.dart';

class RoomSpecifications extends StatelessWidget {
  Function onBtnClick;
  Function onClose;

  RoomSpecifications(this.onBtnClick, {required this.onClose});

  @override
  Widget build(BuildContext context) {
    return MyKiloBamayaPageModel(
      showBackBtn: false,
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
            textInputAction: TextInputAction.done,
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
              if (acceptedInput()) {
                onBtnClick();
              }
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
            style: const TextStyle(color: Colors.black),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]")),],
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
    if (teamsNumEt != null &&
        playersNumEt != null &&
        roomNameEt != null) {
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
