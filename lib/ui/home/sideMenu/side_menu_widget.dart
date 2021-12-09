// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable, use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glass_container/glass_container.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

import 'designer_widget.dart';

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
        width: width * .6,
        child: GlassContainer(
          contColor: MyColors.lightBlue.withOpacity(.20),
          borderRadiusColor: Colors.transparent,
          contHeight: double.infinity,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                              color: MyColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Offstage(
                          offstage: isAboutClicked,
                          child: const Text(
                            'Kilo Bamia is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                            style: TextStyle(color: MyColors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    onAboutClick),
                MenuItem(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Other Apps',
                          style: TextStyle(
                              color: MyColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Offstage(
                          offstage: isOtherAppsClicked,
                          child: const Text(
                            'Alfurqan',
                            style: TextStyle(color: MyColors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    onOtherAppsClick),
                Expanded(
                  child: MenuItem(Container(), () {}),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 48),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 4, color: MyColors.blueShadowClr),
                    )),
                    child: Row(
                      children: [
                        Expanded(
                            child: OurDescription(
                          jobTitle: 'Developer',
                          name: 'Abdullah',
                          onClick: onDeveloperClick,
                        )),
                        Container(
                          width: 4,
                          height: 23,
                          decoration: BoxDecoration(
                            color: MyColors.blueShadowClr,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Expanded(
                            child: OurDescription(
                          jobTitle: 'Designer',
                          name: 'Obada',
                          onClick: onDesignerClick,
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDesignerClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DesignerWidget()));
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
      child: ClipPath(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          child: GlassContainer(
            borderRadiusColor: Colors.transparent,
            contColor: Colors.transparent,
            child: content,
          ),
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
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Text(
              jobTitle,
              style: const TextStyle(fontSize: 12, color: MyColors.lightBlack),
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
    );
  }
}
