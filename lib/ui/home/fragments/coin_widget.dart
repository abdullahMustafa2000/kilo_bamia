import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

class CoinWidget extends StatefulWidget {
  @override
  State<CoinWidget> createState() => _CoinWidgetState();
}

class _CoinWidgetState extends State<CoinWidget> with TickerProviderStateMixin {
  var verticalSpin = 0.0;
  var counter = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  var num = Random().nextInt(2);
  var arr = [60, 70];
  Widget img = Image.asset('assets/images/coin_king.png');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 132));
    //resetAnimation();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [MyColors.homeBg, MyColors.white])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .001)
                ..rotateX(verticalSpin / 180 * pi),
              child: Center(
                child: img,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: width * .25,
                  height: width * .25,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 22,
                                  color: MyColors.darkOrange.withOpacity(.25),
                                  spreadRadius: 12)
                            ],
                            gradient: const LinearGradient(colors: [
                              MyColors.lightYellow,
                              MyColors.darkYellow,
                            ], stops: [
                              .5,
                              .5,
                            ])),
                      ),
                      InkWell(
                        onTap: () {
                          if (counter == 0) {
                            resetAnimation();
                            startAnimation();
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(180),
                          child: Container(
                            width: width * .22,
                            height: width * .22,
                            color: MyColors.darkOrange,
                            child: const Center(
                                child: Text(
                              'Throw!',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.white),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  setImage() {
    if (verticalSpin <= 90 || verticalSpin >= 270) {
      img = Image.asset('assets/images/coin_king.png');
    } else {
      img = Transform(
        transform: Matrix4.identity()..rotateX(pi),
        alignment: Alignment.center,
        child: Image.asset('assets/images/coin_write.png'),
      );
    }
  }

  onSpinning(int no) {
    verticalSpin += no;
    verticalSpin %= 360;
    setImage();
    setState(() {});
  }

  void resetAnimation() {
    setImage();
    _controller.reset();
  }

  onSpinningEnd() {
    final double mEnd = 360 - verticalSpin >= 180 ? 360 : 0;
    _animation =
        Tween<double>(begin: verticalSpin, end: mEnd).animate(_controller)
          ..addListener(() {
            setState(() {
              verticalSpin = mEnd;
            });
          });
    _controller.forward();
    counter = 0;
    setState(() {
    });
  }

  void startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      counter++;
      if (counter == arr[num > arr.length -1 ? 1: num]) {
        print(arr[num]);
        num = Random().nextInt(2);
        onSpinningEnd();
        _timer.cancel();
        return;
      }

      onSpinning(counter);
    });
  }
}
/*

class CoinImage extends StatefulWidget {
  @override
  State<CoinImage> createState() => _CoinImageState();
}

class _CoinImageState extends State<CoinImage> with TickerProviderStateMixin {
  var verticalSpin = 0.0;
  var counter = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  late CoinAnimationProvider provider;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1));
    provider = Provider.of<CoinAnimationProvider>(context);
    resetAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, .001)
          ..rotateX(verticalSpin / 180 * pi),
        child: Center(
          child: setImage(),
        ),
      ),
    );
  }

  Widget setImage() {
    if (verticalSpin <= 90 || verticalSpin >= 270) {
      return Image.asset('assets/images/coin_king.png');
    } else {
      return Transform(
        transform: Matrix4.identity()..rotateX(pi),
        alignment: Alignment.center,
        child: Image.asset('assets/images/coin_write.png'),
      );
    }
  }

  onSpinning(int no) {
    verticalSpin += no;
    verticalSpin %= 360;
  }

  resetAnimation() {
    _controller.reset();
  }

  onSpinningEnd() {
    final double mEnd = 360 - verticalSpin >= 180 ? 360 : 0;
    _animation =
        Tween<double>(begin: verticalSpin, end: mEnd).animate(_controller)
          ..addListener(() {
            setState(() {
              verticalSpin = _animation.value;
            });
          });
    _controller.forward();
    provider.endAnimation();
    print('animation has ended $counter');
  }

  void startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 132), (timer) {
      counter++;

      if (counter == 45) {
        onSpinningEnd();
        _timer.cancel();
        return;
      }

      onSpinning(counter);
      setState(() {});
    });
  }
}
*/
