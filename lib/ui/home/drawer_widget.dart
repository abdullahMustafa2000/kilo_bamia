import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glass_container/glass_container.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GlassContainer(
        contWidth: width * .6,
        borderRadiusColor: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MenuItem(Center(
                child: Image.asset('assets/images/kitty.png', width: 42, height: 46,),
              ), (){}),

              MenuItem(Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('About', style: TextStyle(color: MyColors.white, fontWeight: FontWeight.bold),),
                  Text('Kilo Bamia is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.', style: TextStyle(color: MyColors.white), textAlign: TextAlign.center,),
                ],
              ), (){}),

              MenuItem(Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Other Apps', style: TextStyle(color: MyColors.white, fontWeight: FontWeight.bold),),
                  Text('Alfuqan', style: TextStyle(color: MyColors.white),),
                ],
              ), (){}),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  Widget content;
  Function onClick;


  MenuItem(this.content, this.onClick);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClick();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: GlassContainer(
          radius: BorderRadius.circular(20),
          child: content,
        ),
      ),
    );
  }
}
