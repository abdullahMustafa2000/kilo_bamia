import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  Color contentColor, shadowColor;
  Widget content;
  CircularContainer(
      {required this.contentColor,
        required this.shadowColor,
        required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47,
      height: 47,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(180),
          color: contentColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 0,
              blurRadius: 30,
              offset: const Offset(0, 0),
            )
          ]),
      child: Center(
        child: content,
      ),
    );
  }
}
