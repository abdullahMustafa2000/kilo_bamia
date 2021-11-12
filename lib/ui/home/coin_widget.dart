import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

class CoinWidget extends StatelessWidget {
  const CoinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient:
          LinearGradient(colors: [MyColors.homeBg, MyColors.white])),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CoinImage(),
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
                              spreadRadius: 12
                            )
                          ],
                          gradient: const LinearGradient(
                            colors: [
                              MyColors.lightYellow,
                              MyColors.darkYellow,
                            ],
                            stops: [
                              .5,
                              .5,
                            ]
                          )
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(180),
                        child: Container(
                          width: width * .22,
                          height: width * .22,
                          color: MyColors.darkOrange,
                          child: const Center(child: Text('Throw!', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.white),)),
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
}

class CoinImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Center(
        child: Image.asset('assets/images/coin_king.png'),
      ),
    );
  }
}
