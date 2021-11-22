import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/pages/page_model.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return MyKiloBamayaPageModel(
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
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TeamDesign(
                      teamMembers: const ['Obada', 'Bsyone', 'Tarek', '3zo', 'Obada', 'Bsyone', 'Tarek', '3zo'],
                      teamColor: colorsArr[index],
                      teamIndex: index);
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
    MyColors.lightRed,
    MyColors.darkOrange,
  ];

  Widget saveBtn() {
    return Container(
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
    );
  }

  Widget reSpinBtn() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 47,
      height: 47,
      decoration: BoxDecoration(
        borderRadius:
        const BorderRadius.all(Radius.circular(180.0)),
        boxShadow: [
          BoxShadow(
              blurRadius: 22,
              color: MyColors.darkOrange.withOpacity(.25),
              spreadRadius: 12)
        ],
      ),
      child: RaisedButton(
        onPressed: () {},
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
                borderRadius: const BorderRadius.all(
                    Radius.circular(80.0))),
            constraints: const BoxConstraints(
                minWidth: 88.0,
                minHeight:
                36.0), // min sizes for Material buttons
            alignment: Alignment.center,
            child: Text('Spin Again',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption),
          ),
        ),
      ),
    );
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
                'Team ${teamIndex+1}',
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
