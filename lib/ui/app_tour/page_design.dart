// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/app_tour/view_page_provider.dart';
import 'package:kilo_bamya/ui/home/home_screen.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatefulWidget {
  String title;
  String desc;
  String btnTxt;
  Widget view;
  Function onBtnClick;
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
    var provider = Provider.of<MyViewPageProvider>(context);
    var _currentPageNotifier = provider.currentPageNotifier;
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
              style: const TextStyle(fontSize: 32),
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
                  child: CirclePageIndicator(
                    size: 13,
                    selectedSize: 13,
                    itemCount: 3,
                    currentPageNotifier: _currentPageNotifier,
                    selectedDotColor: MyColors.lightBlue,
                    dotColor: MyColors.lightGray,
                  ),
                ),

                /// btn
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  width: containerWidth * .3,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onBtnClick(widget.btnTxt);
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: isNotFinalPage? MyColors.darkBlue.withOpacity(.1): MyColors.darkBlue,
                        borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: Text(
                          widget.btnTxt,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: isNotFinalPage?MyColors.lightBlack.withOpacity(0.9):MyColors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomePage()));
                    },
                    child: Visibility(
                      visible: provider.currentPageIndex == 0,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: const Text(
                          'Skip',
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
