import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/app_tour/page_view_widget.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:kilo_bamya/ui/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _releaseSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          TopScreen(screenSize),
          MidScreen(screenSize),
          BottomScreen(),
        ],
      )),
    );
  }

  void _releaseSplashScreen() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    bool firstRun = await IsFirstRun.isFirstRun();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                firstRun ? MyPageViewController() : const HomePage()));
  }
}

class BottomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: Container(
      color: MyColors.lightBlack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NameOfAppTextDesign(name: 'Bamia', color: MyColors.darkBlue),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Created By :',
                  style: TextStyle(color: MyColors.white.withOpacity(.33)),
                ),
                DADName('Abdullah'),
                DADName('Obada'),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class NameOfAppTextDesign extends StatelessWidget {
  String name;
  Color color;
  NameOfAppTextDesign({required this.name, required this.color});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: TextStyle(
            color: color,
            fontSize: 60,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class DADName extends StatelessWidget {
  String developerName;
  DADName(this.developerName);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        '-$developerName',
        style: TextStyle(color: MyColors.darkBlue.withOpacity(.33)),
      ),
    );
  }
}

class MidScreen extends StatelessWidget {
  Size screenSize;
  MidScreen(this.screenSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: screenSize.height * .03,
      color: MyColors.white,
    );
  }
}

class TopScreen extends StatelessWidget {
  Size screenSize;
  TopScreen(this.screenSize);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: screenSize.height * .4,
        width: double.infinity,
        color: MyColors.darkBlue,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: NameOfAppTextDesign(name: 'Kilo', color: MyColors.lightBlack),
        ));
  }
}
