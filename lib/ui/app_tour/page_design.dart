// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/home_screen.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class IntroPage extends StatefulWidget {
  String title;
  String desc;
  String btnTxt;
  Widget view;
  Function(int) onBtnClick;
  int index;

  IntroPage(
      {required this.title,
      required this.desc,
      required this.btnTxt,
      required this.view,
      required this.onBtnClick,
      required this.index});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    var containerWidth = MediaQuery.of(context).size.width;
    bool isNotFinalPage = widget.btnTxt.contains('x');
    // main view
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              width: containerWidth * 0.7,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [MyColors.topGradient, MyColors.bottomGradient])),
              child: widget.view,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.k2d(
                textStyle: const TextStyle(
                  fontSize: 34,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),

          /// bottom view
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [MyColors.bottomGradient, MyColors.topGradient])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.desc,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: PageViewDotIndicator(
                    currentItem: widget.index,
                    count: 3,
                    unselectedColor: MyColors.lightGray,
                    selectedColor: MyColors.lightBlue,
                    size: const Size(13, 13),
                    boxShape: BoxShape.circle,
                  ),
                ),
                /// btn
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  width: containerWidth * .3,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onBtnClick(widget.index);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor: MaterialStateProperty.all(
                        isNotFinalPage ? MyColors.lightBlue : MyColors.darkBlue,
                      ),
                    ),
                    child: Text(
                      widget.btnTxt,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: isNotFinalPage
                                ? MyColors.lightBlack.withOpacity(0.9)
                                : MyColors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: widget.index < 2,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => const HomePage()));
                        },
                        child: Text(
                          getLocalization(context).skipTour,
                          style: TextStyle(color: MyColors.lightGray),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

/*
ElevatedButton(
            onPressed: () {
              widget.onBtnClick(widget.btnTxt);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              backgroundColor: MaterialStateProperty.all(MyColors.someOrange),
            ),
            child: Text(
                          widget.btnTxt,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: isNotFinalPage
                                  ? MyColors.lightBlack.withOpacity(0.9)
                                  : MyColors.white),
                        ),
          ),


          ElevatedButton(
                    onPressed: () {
                      widget.onBtnClick(widget.btnTxt);
                    },
                    style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              backgroundColor: MaterialStateProperty.all(MyColors.someOrange),
            ),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: isNotFinalPage
                            ? MyColors.darkBlue.withOpacity(.1)
                            : MyColors.darkBlue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 88.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: Text(
                          widget.btnTxt,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: isNotFinalPage
                                  ? MyColors.lightBlack.withOpacity(0.9)
                                  : MyColors.white),
                        ),
                      ),
                    ),
                  )
 */
