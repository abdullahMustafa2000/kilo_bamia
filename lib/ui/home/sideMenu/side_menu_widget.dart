// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable, use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/sideMenu/custom_border.dart';
///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
class MyDrawerWidget extends StatefulWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);

  @override
  State<MyDrawerWidget> createState() => _MyDrawerWidgetState();
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  bool isAboutClicked = false;

  bool isOtherAppsClicked = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        width: width * .5,
        child: ClipRRect(
          borderRadius: BorderRadius.zero,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.blueShadowClr.withOpacity(.4),
                  borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Center(
                      child: Image.asset(
                        'assets/images/kitty.png',
                        width: 42,
                        height: 46,
                      ),
                    ),
                  ),
                  MenuItem(
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(
                            child: Text(
                              'About',
                              style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          Offstage(
                            offstage: isAboutClicked,
                            child: const Center(
                              child: Text(
                                'Kilo Bamia is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                                style:
                                    TextStyle(color: MyColors.white, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onAboutClick),
                  MenuItem(
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           const Center(
                            child: Text(
                              'Other Apps',
                              style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          Offstage(
                            offstage: isOtherAppsClicked,
                            child: const Center(
                              child: Text(
                                'Alfurqan',
                                style:
                                    TextStyle(color: MyColors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onOtherAppsClick),
                  Expanded(
                    child: ClipPath(
                      clipper: MyUpCustomClipper(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onAboutClick() {
    setState(() {
      isAboutClicked = !isAboutClicked;
    });
  }

  void onDeveloperClick() {}

  void onOtherAppsClick() {
    setState(() {
      isOtherAppsClicked = !isOtherAppsClicked;
    });
  }
}

class MenuItem extends StatelessWidget {
  Widget content;
  Function onClick;

  MenuItem(this.content, this.onClick);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: content,
            ),
            Positioned.fill(
                child: ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                color: MyColors.blueShadowClr,
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class OurDescription extends StatelessWidget {
  String jobTitle;
  String name;
  Function onClick;
  OurDescription(
      {required this.jobTitle, required this.name, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              Text(
                jobTitle,
                style:
                    const TextStyle(fontSize: 12, color: MyColors.lightBlack),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: MyColors.darkBlue),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
