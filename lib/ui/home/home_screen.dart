import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/wheel_widget.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.menu),
            Expanded(child: Text('Kilo Bamia', style: TextStyle(fontSize: 34), textAlign: TextAlign.center,)),
          ],
        ),
        backgroundColor: MyColors.darkBlue,
      ),

      body: WheelWidget(),
    );
  }
}
