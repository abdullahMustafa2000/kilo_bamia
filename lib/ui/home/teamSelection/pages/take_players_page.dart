// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kilo_bamya/local_db/game_model.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/teamSelection/page_model.dart';
import 'package:kilo_bamya/ui/home/teamSelection/pages/room_specifications.dart';
import 'package:kilo_bamya/ui/home/teamSelection/teams_provider.dart';
import 'package:provider/provider.dart';

class RoomPlayers extends StatefulWidget {
  Function onBtnClick;
  Function onClose;
  Function onPrev;
  GameModel? gameModel;
  RoomPlayers(
      {required this.onBtnClick, required this.onClose, required this.onPrev, this.gameModel});

  @override
  State<RoomPlayers> createState() => _RoomPlayersState();
}

class _RoomPlayersState extends State<RoomPlayers> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TeamProvider>(context);
    var size = MediaQuery.of(context).size;
    return MyKiloBamayaPageModel(
      showBackBtn: true,
      onPrev: widget.onPrev,
      onClose: widget.onClose,
      content: SizedBox(
        height: size.height * .3,
        child: Column(
          children: [
            Text(
              'Enter names :',
              style: Theme.of(context).textTheme.headline4,
            ),
            Expanded(
              child: Form(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.gameModel?.noOfPlayers,
                  itemBuilder: (BuildContext context, int index) {
                    return TextInputDesign(onTextChange, index);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                  ),
                ),
              ),
            ),
            Container(
              width: 47,
              height: 47,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(180.0)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 22,
                      color: MyColors.darkOrange.withOpacity(.25),
                      spreadRadius: 12)
                ],
              ),
              // child: RaisedButton(
              //   onPressed: () {
              //     provider.players = names;
              //     widget.onBtnClick();
              //   },
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(180.0)),
              //   padding: const EdgeInsets.all(0.0),
              //   child: Ink(
              //     child: Container(
              //       decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //               begin: Alignment.topCenter,
              //               end: Alignment.bottomCenter,
              //               colors: [
              //                 MyColors.lightOrange.withOpacity(.1),
              //                 MyColors.darkOrange.withOpacity(.3),
              //               ]),
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(80.0))),
              //       constraints: const BoxConstraints(
              //           minWidth: 88.0,
              //           minHeight: 36.0), // min sizes for Material buttons
              //       alignment: Alignment.center,
              //       child: Text(
              //         'Spin!',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             fontSize: 16,
              //             color: MyColors.lightBlack.withOpacity(0.9)),
              //       ),
              //     ),
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }

  List<String> names = List.filled(int.parse(InputContainer.playersNumEt!), '');
  onTextChange(String name, int index) {
    names[index] = name;
  }

}

class TextInputDesign extends StatefulWidget {
  TextInputDesign(this.onTxtChange, this.index);
  Function(String, int) onTxtChange;
  int index;

  @override
  State<TextInputDesign> createState() => _TextInputDesignState();
}

class _TextInputDesignState extends State<TextInputDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.textFieldFillClr.withOpacity(.45),
      ),
      child: TextFormField(
        onChanged: (txt) {
          widget.onTxtChange(txt, widget.index);
        },
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: MyColors.lightBlack,
        ),
        textInputAction: TextInputAction.next,
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.subtitle1,
          hintText: 'name',
        ),
      ),
    );
  }
}
