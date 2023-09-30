import 'package:flutter/material.dart';

class SpinningWheel extends StatefulWidget {
  Function? onClick;
  int? animDuration;
  SpinningWheel({this.onClick, this.animDuration});

  @override
  State<SpinningWheel> createState() => _SpinningWheel();
}

class _SpinningWheel extends State<SpinningWheel>
  with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this,
            duration: Duration(seconds: widget.animDuration ?? 2));
    _animation = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
              turns: _animation,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/spinning_wheel.png',
                width: size.width * .8,
              )),
          Image.asset(
            'assets/images/kitty.png',
            width: size.width * .25,
          ),
        ],
      ),
    );
  }
}