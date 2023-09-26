import 'package:flutter/material.dart';
import 'package:kilo_bamya/generated/l10n.dart';
import 'package:kilo_bamya/local_db/database.dart';
import 'package:kilo_bamya/local_db/game_model.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/randomChoice/pages/spinning_wheel_page.dart';

class WheelWidget extends StatelessWidget {
  Function(int, int, {GameModel gameModel}) aboveWidgetCall;

  WheelWidget({required this.aboveWidgetCall});
  List<GameModel>? recentList;
  void refreshRecent() async {
    recentList = await GamesDatabase.instance.readAll();
  }

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
              child: Center(child: InkWell(child: AnimatedWheelRow(
                onWidgetClick: () {
                  aboveWidgetCall(0, 1);
                },
              ))),
            ),
            InkWell(
              onTap: () {
                aboveWidgetCall(0, 0);
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
                      child: Text(
                        S().btnCreateGame,
                        style: const TextStyle(fontSize: 22),
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
                      child: Text(
                        S().titleRecent,
                        style: const TextStyle(fontSize: 24),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                    ),
                    RecentListWidget(
                        gameModels: recentList??[],
                        onItemClick: (gameModel) {
                          aboveWidgetCall(1, 0, gameModel: gameModel);
                        })
                  ],
                ),
              ]),
            ),

            const SizedBox(
              height: 15,
            )
          ],
        ));
  }
}

class RecentListWidget extends StatelessWidget {
  Function(GameModel) onItemClick;
  List<GameModel> gameModels;
  RecentListWidget(
      {required this.gameModels,
      required this.onItemClick,});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) =>
            RecentsItem(gameModel: gameModels[index], onItemClick: onItemClick),
        itemCount: gameModels.length,
      ),
    );
  }
}

class RecentsItem extends StatelessWidget {
  Function(GameModel) onItemClick;
  GameModel gameModel;
  RecentsItem({required this.gameModel, required this.onItemClick});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(gameModel);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Container(
                  width: 45,
                  height: 45,
                  color: MyColors.spinnerColorsArray[0],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(gameModel.roomName!),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                        '${gameModel.noOfPlayers} Players , ${gameModel.noOfTeams} Teams'),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(gameModel.time.toString()),
          )
        ],
      ),
    );
  }
}


