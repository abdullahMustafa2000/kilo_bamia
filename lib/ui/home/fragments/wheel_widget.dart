import 'package:flutter/material.dart';
import 'package:kilo_bamya/moduls/room_module.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/teams_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WheelWidget extends StatelessWidget {
  Function(int) aboveWidgetCall;

  WheelWidget({required this.aboveWidgetCall});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [MyColors.homeBg, MyColors.white])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                  child: Image.asset('assets/images/spinning_wheel.png')),
            ),
            InkWell(
              onTap: () {
                aboveWidgetCall(0);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/create_room_bg.png'),
                    Container(
                      alignment: Alignment.center,
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.lightBlack.withOpacity(.07),
                      ),
                      child: const Text(
                        'Create Game',
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Center(
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            color: MyColors.darkBlue,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.add_rounded,
                              size: 28,
                              color: MyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// lasts design
            SizedBox(
              height: 110,
              child: Stack(children: [
                Image.asset(
                  'assets/images/lasts_bg.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: const Text(
                        'Last : ',
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                    ),
                    Expanded(
                        child: Container(
                      child: RoomItem(
                        onLastClick: () {
                          aboveWidgetCall(1);
                        },
                      ),
                      margin: const EdgeInsets.only(left: 32),
                    ))
                  ],
                ),
              ]),
            )
          ],
        ));
  }
}

/*
class RoomsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32),
      child: InkWell(
        onTap: () {

        },
        child: RoomItem(),
      ),
    );
  }
}
*/

class RoomItem extends StatefulWidget {
  Function onLastClick;

  RoomItem({required this.onLastClick});

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  var roomName;

  var noOfPlayers;

  var noOfTeams;

  var date;

  @override
  void initState() {
    super.initState();
  }

  late SharedPreferences pref;
  Future<void> initiateSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  void getDataFromSharedPreferences() async {
    roomName = pref.getString(RoomModule.room_name_prefKey) ?? '';
    date = pref.getString(RoomModule.create_date_prefKey) ?? '';
    noOfPlayers = pref.getInt(RoomModule.num_of_players_prefKey) ?? -1;
    noOfTeams = pref.getInt(RoomModule.num_of_teams_prefKey) ?? -1;
    print(roomName);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TeamProvider>(context);
    if (provider.divided) {
      getDataFromSharedPreferences();
      setState(() {
        provider.divided = false;
      });
    }
    return FutureBuilder<void>(
      future: initiateSharedPref(),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            getDataFromSharedPreferences();
            return roomRow();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget roomRow() {
    return InkWell(
      onTap: () {
        widget.onLastClick();
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(180),
            child: Container(
              width: 45,
              height: 45,
              color: MyColors.lightRed.withOpacity(.5),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '$noOfPlayers Players , $noOfTeams Teams',
                    style: const TextStyle(
                        fontSize: 14, color: MyColors.lightBlack),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(date,
                style: const TextStyle(
                    fontSize: 14, color: MyColors.lightBlack)),
          )
        ],
      ),
    );
  }
}
