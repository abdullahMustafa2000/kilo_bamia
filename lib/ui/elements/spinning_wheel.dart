import 'package:flutter/material.dart';

class SpinningWheel extends StatefulWidget {
  Function? onClick, wheelAnimController;
  int? animDuration;
  double? kittyPerc, wheelPerc;
  Animation<double>? kittyFadeOutAnimation;
  SpinningWheel(
      {this.onClick,
      this.animDuration,
      this.kittyPerc,
      this.wheelPerc,
      this.wheelAnimController,
      this.kittyFadeOutAnimation});

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
    _animController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.animDuration ?? 2));
    _animation = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.repeat();
    if (widget.wheelAnimController != null) {
      widget.wheelAnimController!(_animController);
    }
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
            child: _wheelImage(size),
          ),
          widget.kittyFadeOutAnimation == null
              ? _kittyImage(size)
              : FadeTransition(
                  opacity: widget.kittyFadeOutAnimation!,
                  child: _kittyImage(size),
                ),
        ],
      ),
    );
  }

  Widget _kittyImage(Size size) => Image.asset(
      'assets/images/kitty.png',
      width: size.width * (widget.kittyPerc ?? .25));

  Widget _wheelImage(Size size) => Image.asset(
    'assets/images/spinning_wheel.png',
    width: size.width * (widget.wheelPerc ?? .8),
  );
}
