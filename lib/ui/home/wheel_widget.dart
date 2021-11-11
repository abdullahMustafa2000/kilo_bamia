import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

class WheelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [MyColors.homeBg, MyColors.white])),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset('assets/images/spinning_wheel.png'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MyColors.lightBlack.withOpacity(.07),
                    ),
                    child: const Text(
                      'Create Room',
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
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
                        size: 24,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// lasts design
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          MyColors.bottomGradient,
                          MyColors.topGradient
                        ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: const Text(
                        'Lasts : ',
                        style: TextStyle(fontSize: 24),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                    ),
                    RoomsListWidget()
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class RoomsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32),
      child: Column(
        children: [
          RoomItem(MyColors.lightRed.withOpacity(.5), 'First Room Name', 20, 4),
          Container(
            width: 220,
            height: 1,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8),
            color: MyColors.lightBlack.withOpacity(.1),
          ),
          RoomItem(
              MyColors.darkBlue.withOpacity(.5), 'Second Room Name', 15, 3),
        ],
      ),
    );
  }
}

class RoomItem extends StatelessWidget {
  Color imgColor;
  String roomName;
  int players;
  int teams;

  RoomItem(this.imgColor, this.roomName, this.players, this.teams);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(180),
          child: Container(
            width: 45,
            height: 45,
            color: imgColor,
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
                  '$players Players , $teams Teams',
                  style:
                      const TextStyle(fontSize: 14, color: MyColors.lightBlack),
                ),
              ],
            ),
          ),
        ),
        const Text('12 Dec',
            style: TextStyle(fontSize: 14, color: MyColors.lightBlack))
      ],
    );
  }
}
