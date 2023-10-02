import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/models/game_model.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/elements/spinning_wheel.dart';

class WheelWidget extends StatelessWidget {
  final Function(
      {required bool openSplitResult,
      required bool openRandomChoice,
      GameModel? gameModel}) aboveWidgetCall;

  const WheelWidget({Key? key, required this.aboveWidgetCall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [MyColors.homeBg, MyColors.white])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: InkWell(
                child: SpinningWheel(
                  onClick: () {
                    // aboveWidgetCall(0, 1);
                    aboveWidgetCall(
                        openSplitResult: false, openRandomChoice: true);
                  },
                  animDuration: 40,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              aboveWidgetCall(openSplitResult: false, openRandomChoice: false, gameModel: GameModel.init());
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
                      getLocalization(context).btnCreateRoom,
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(fontSize: 22),
                      ),
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

          /// recent design
          SizedBox(
            height: 110,
            child: Stack(children: [
              Image.asset(
                'assets/images/lasts_bg.png',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      getLocalization(context).recentListTitle,
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    RecentListWidget(onItemClick: (gameModel) {
                      // aboveWidgetCall(1, 0, gameModel: gameModel);
                      aboveWidgetCall(
                          openSplitResult: true,
                          openRandomChoice: false,
                          gameModel: gameModel);
                    })
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class RecentListWidget extends StatefulWidget {
  final Function(GameModel) onItemClick;

  const RecentListWidget({
    Key? key,
    required this.onItemClick,
  }) : super(key: key);

  @override
  State<RecentListWidget> createState() => _RecentListWidgetState();
}

class _RecentListWidgetState extends State<RecentListWidget> {
  late List<GameModel> _recentGames;

  void updateRecent(Map<Object?, Object?> recent) {
    _recentGames.clear();
    recent.forEach((key, value) {
      _recentGames.add(GameModel.fromJson(value as Map));
    });
    setState(() {});
  }

  @override
  void initState() {
    _recentGames = [];
    teamsDatabase().onValue.listen((event) {
      if (event.snapshot.exists) {
        updateRecent(event.snapshot.value as Map);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _recentGames.isEmpty
          ? Center(
              child: Text(
                getLocalization(context).emptyListMessage,
                style: GoogleFonts.k2d(),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => RecentItem(
                  gameModel: _recentGames[index],
                  onItemClick: widget.onItemClick),
              itemCount: _recentGames.length,
            ),
    );
  }
}

class RecentItem extends StatelessWidget {
  final Function(GameModel) onItemClick;
  final GameModel gameModel;
  const RecentItem(
      {Key? key, required this.gameModel, required this.onItemClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(gameModel);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(180),
                      child: Container(
                        width: 45,
                        height: 45,
                        color: MyColors.spinnerColorsArray[0],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        gameModel.roomName ?? 'Game',
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${gameModel.noOfPlayers} Players, ${gameModel.noOfTeams} Teams',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text('${gameModel.time?.day}/${gameModel.time?.month}')
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 1,
            color: MyColors.topGradient,
          ),
        ],
      ),
    );
  }
}

/*

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
                    padding: const EdgeInsets.all(4.0),
                    child: Text(gameModel.roomName ?? 'Game'),
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
            child: Text('${gameModel.time?.day}/${gameModel.time?.month}'),
          )
 */
