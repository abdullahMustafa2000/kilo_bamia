import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/pages/page_model.dart';

class RoomPlayers extends StatefulWidget {
  Function onBtnClick;


  RoomPlayers({required this.onBtnClick});

  @override
  State<RoomPlayers> createState() => _RoomPlayersState();
}

class _RoomPlayersState extends State<RoomPlayers> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MyKiloBamayaPageModel(
      content: SizedBox(
        height: size.height * .3,
        child: Column(
          children: [
            Text(
              'Enter names :',
              style: Theme.of(context).textTheme.headline4,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return const TextInputDesign();
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12, childAspectRatio: 1/.5),
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
              child: RaisedButton(
                onPressed: () {
                  widget.onBtnClick();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(180.0)),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(80.0))),
                    constraints: const BoxConstraints(
                        minWidth: 88.0,
                        minHeight: 36.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: Text(
                      'Spin!',
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
        ),
      ),
    );
  }
}

class TextInputDesign extends StatelessWidget {
  const TextInputDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.textFieldFillClr.withOpacity(.45),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.subtitle1,
          hintText: 'name',
        ),
      ),
    );
  }
}
