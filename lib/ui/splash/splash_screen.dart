import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/app_tour/page_view_widget.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Image.asset(
          'assets/images/splash_screen.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void _releaseSplashScreen() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyPageViewController()));
  }
}
