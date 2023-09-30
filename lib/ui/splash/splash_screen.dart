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
              const BottomScreen(),
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
  const BottomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: MyColors.lightBlack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const NameOfAppTextDesign(name: 'Bamia', color: MyColors.darkBlue),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Created By :',
                  style: TextStyle(color: MyColors.white.withOpacity(.33)),
                ),
                const DADName('Abdullah'),
                const DADName('Obada'),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class NameOfAppTextDesign extends StatelessWidget {
  final String name;
  final Color color;
  const NameOfAppTextDesign({Key? key, required this.name, required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
  final String developerName;
  const DADName(this.developerName, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '-$developerName',
        style: TextStyle(color: MyColors.darkBlue.withOpacity(.33)),
      ),
    );
  }
}

class MidScreen extends StatelessWidget {
  final Size screenSize;
  const MidScreen(this.screenSize, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenSize.height * .03,
      color: MyColors.white,
    );
  }
}

class TopScreen extends StatelessWidget {
  final Size screenSize;
  const TopScreen(this.screenSize, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenSize.height * .4,
        width: double.infinity,
        color: MyColors.darkBlue,
        child: const Align(
          alignment: Alignment.bottomCenter,
          child: NameOfAppTextDesign(name: 'Kilo', color: MyColors.lightBlack),
        ));
  }
}
