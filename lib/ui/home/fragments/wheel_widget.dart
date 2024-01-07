import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [MyColors.homeBg, MyColors.white]),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                margin: const EdgeInsets.only(top: 24),
                child: InkWell(
                  child: SpinningWheel(
                    onClick: () {
                      aboveWidgetCall(
                          openSplitResult: false, openRandomChoice: true);
                    },
                    animDurationInSec: 40,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  aboveWidgetCall(
                      openSplitResult: false,
                      openRandomChoice: false,
                      gameModel: GameModel.init());
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
              Expanded(
                child: Stack(children: [
                  Image.asset(
                    'assets/images/lasts_bg.png',
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
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
                        RecentListWidget(
                          onItemClick: (gameModel) {
                            aboveWidgetCall(
                              openSplitResult: true,
                              openRandomChoice: false,
                              gameModel: gameModel,
                            );
                          },
                        )
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
        ),
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
  late Box<GameModel> allSplits;

  @override
  void initState() {
    allSplits = teamsHiveDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: allSplits.listenable(),
        builder: (context, Box<GameModel> box, _) {
          if (box.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) => RecentItem(
                box: box,
                gameModel: box.getAt(index)!,
                onItemClick: widget.onItemClick,
                index: index,
                recentLength: box.length,
              ),
              itemCount: box.length,
            );
          } else {
            return Center(
              child: Text(
                getLocalization(context).emptyListMessage,
                style: GoogleFonts.k2d(),
              ),
            );
          }
        },
      ),
    );
  }
}

class RecentItem extends StatefulWidget {
  final Function(GameModel) onItemClick;
  final GameModel gameModel;
  final int index;
  final int recentLength;
  final Box<GameModel> box;
  const RecentItem(
      {Key? key,
      required this.gameModel,
      required this.onItemClick,
      required this.index,
      required this.recentLength,
      required this.box})
      : super(key: key);

  @override
  State<RecentItem> createState() => _RecentItemState();
}

class _RecentItemState extends State<RecentItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        child: Center(
          child: Icon(
            Icons.delete_forever_rounded,
            color: Colors.white,
          ),
        ),
        color: MyColors.spinnerLightRed,
      ),
      onDismissed: (DismissDirection direction) {
        setState(() {
          widget.gameModel.delete();
        });
      },
      key: ValueKey<String?>(widget.gameModel.id),
      child: InkWell(
        onTap: () {
          widget.onItemClick(widget.gameModel);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                            color: MyColors
                                .spinnerColorsArray[_curClr(widget.index)],
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              widget.gameModel.roomName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${widget.gameModel.noOfPlayers} ${getLocalization(context).playersLabel}(s), ${widget.gameModel.noOfTeams} ${getLocalization(context).teamsLabel}(s)',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                          '${widget.gameModel.time.day}/${widget.gameModel.time.month}')
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
        ),
      ),
    );
  }

  int _curClr(int index) {
    if (index == MyColors.spinnerColorsArray.length) {
      return 0;
    } else {
      return index++;
    }
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
