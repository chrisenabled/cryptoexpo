

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SimpleLottieIcon extends StatefulWidget {

  final bool loop;
  final String iconPath;
  final double size;
  final bool animate;
  final Function()? isPressed;

  const SimpleLottieIcon({
    this.loop = false,
    this.size = 24,
    this.animate = false,
    required this.iconPath,
    this.isPressed
  });

  void defaultFunction() {}

  @override
  State<StatefulWidget> createState() => _SimpleLottieIconState();

}

class _SimpleLottieIconState extends State<SimpleLottieIcon>
    with TickerProviderStateMixin {

  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;

  Duration animationDuration = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();

    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation = AnimationController(vsync: this, duration: animationDuration);
    if(widget.animate && widget.loop) {
      _runAnimation();
    }
    onSelectedAnimation.addListener(() {
      if(onSelectedAnimation.isCompleted) {
        if(widget.loop) {
          _runAnimation();
        }
      }
    });
  }

  void _runAnimation() {
    onSelectedAnimation.reset();
    onSelectedAnimation.forward();
  }

  @override
  void dispose() {
    super.dispose();

    idleAnimation.dispose();
    onSelectedAnimation.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.isPressed != null) widget.isPressed!();
        if(widget.animate) _runAnimation();
      },
      child: Lottie.asset(
          widget.iconPath,
          height: widget.size,
          controller: widget.animate ? onSelectedAnimation : idleAnimation //onChangedAnimation
      ),
    );
  }

}