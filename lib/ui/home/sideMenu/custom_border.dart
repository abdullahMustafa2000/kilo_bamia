
import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    var width = size.width;
    var height = size.height;
    double point = 10;
    /*path.lineTo(0, point);
    path.lineTo(point, 5);
    path.lineTo(width-point, 5);
    path.lineTo(width, point);
    path.lineTo(width, 0);
    path.close();*/
    double strockH = 1;
    double strockW = 10;
    path.lineTo(0, point);
    path.lineTo(strockW, strockH);
    path.lineTo(width-strockW, strockH);
    path.lineTo(width, point);
    path.lineTo(width, 0);
    path.close();
    path.moveTo(0, height-point);
    path.lineTo(strockW, height-strockH);
    path.lineTo(width-strockW, height-strockH);
    path.lineTo(width, height-point);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}


class MyUpCustomClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    var width = size.width;
    var height = size.height;
    double point = 10;
    /*path.lineTo(0, point);
    path.lineTo(point, 5);
    path.lineTo(width-point, 5);
    path.lineTo(width, point);
    path.lineTo(width, 0);
    path.close();*/
    double strockH = 1;
    double strockW = 10;
    path.lineTo(0, point);
    path.lineTo(strockW, strockH);
    path.lineTo(width-strockW, strockH);
    path.lineTo(width, point);
    path.lineTo(width, 0);
    path.close();
    /*path.moveTo(0, height-point);
    path.lineTo(strockW, height-strockH);
    path.lineTo(width-strockW, height-strockH);
    path.lineTo(width, height-point);
    path.lineTo(width, height);
    path.lineTo(0, height);*/
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}


class MyDownCustomClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    var width = size.width;
    var height = size.height;
    double point = 10;
    /*path.lineTo(0, point);
    path.lineTo(point, 5);
    path.lineTo(width-point, 5);
    path.lineTo(width, point);
    path.lineTo(width, 0);
    path.close();*/
    double strockH = 1;
    double strockW = 10;
    /*path.lineTo(0, point);
    path.lineTo(strockW, strockH);
    path.lineTo(width-strockW, strockH);
    path.lineTo(width, point);
    path.lineTo(width, 0);
    path.close();*/
    path.moveTo(0, height-point);
    path.lineTo(strockW, height-strockH);
    path.lineTo(width-strockW, height-strockH);
    path.lineTo(width, height-point);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

