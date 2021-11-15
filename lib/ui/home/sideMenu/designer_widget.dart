// ignore_for_file: use_key_in_widget_constructors

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';

class DesignerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Image.asset('assets/images/kitty.png', width: 45, height: 45,), padding: const EdgeInsets.all(8),),
            const Center(
              child: DottedLine(
                direction: Axis.vertical,
                lineLength: 20,
              ),
            ),
            Container(child: Image.asset('assets/images/obada_logo.png',), margin: const EdgeInsets.all(4),),
            const Center(
              child: DottedLine(
                direction: Axis.vertical,
                lineLength: 20,
              ),
            ),
            ContactsView(),
          ],
        ),
      ),
    );
  }
}

class ContactsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        rowDesign(Icons.phone, '01117995426'),
        rowDesign(Icons.phone, '01117995426'),
      ],
    );
  }

  Widget rowDesign(IconData icon, String desc) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: MyColors.darkBlue,
              borderRadius: BorderRadius.circular(180),
            ),
            child: Icon(icon),
          ),

          Container(margin: const EdgeInsets.only(left: 4),child: Text(desc, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,), textAlign: TextAlign.center,))
        ],
      ),
    );
  }
}
