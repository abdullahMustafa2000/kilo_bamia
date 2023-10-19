// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable, use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/sideMenu/custom_border.dart';

///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
class MyDrawerWidget extends StatefulWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);

  @override
  State<MyDrawerWidget> createState() => _MyDrawerWidgetState();
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
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
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(isRTL(context)? 0 : 30),
                    bottomRight: Radius.circular(isRTL(context)? 0 : 30),
                    topLeft: Radius.circular(isRTL(context)? 30 : 0),
                    bottomLeft: Radius.circular(isRTL(context)? 30 : 0)
                  ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //kitty image
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
                  //About
                  MenuItem(
                    title: "About",
                    desc: "About Description",
                    onClick: () {},
                  ),
                  //other apps
                  MenuItem(
                      title: "Other Apps",
                      desc: "Al Furkan",
                      onClick: () {}),

                  Expanded(
                    child: ClipPath(
                      clipper: MyUpCustomClipper(),
                    ),
                  ),
                  //DesignerDeveloperInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DesignerDeveloperInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white, width: 2.5))),
        child: Row(
          children: [
            card('Developer', 'Abdullah', () {}, context),
            separatorWidget(),
            card('Designer', 'Obada', () {}, context),
          ],
        ),
      );

  Widget card(String title, String name, Function onNameClick,
          BuildContext context) =>
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                        fontSize: 16, color: MyColors.someOrange)),
              ),
              Text(
                name,
                style: GoogleFonts.k2d(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: MyColors.spinnerLightBlue),
                ),
              ),
            ],
          ),
        ),
      );

  Widget separatorWidget() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 20,
        width: 2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
      );
}

class MenuItem extends StatefulWidget {
  Function onClick;
  String title, desc;
  MenuItem({required this.title, required this.desc, required this.onClick});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool widgetTaped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClick();
        setState(() {
          widgetTaped = !widgetTaped;
        });
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          color: MyColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Offstage(
                    offstage: !widgetTaped,
                    child: Center(
                      child: Text(
                        widget.desc,
                        style: const TextStyle(
                            color: MyColors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
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
