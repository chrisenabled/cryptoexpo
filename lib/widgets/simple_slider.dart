

import 'package:flutter/material.dart';

class SimpleSlider extends StatelessWidget {

  final Widget slide;
  final bool isUpDownAnimation;
  final int? milliseconds;

  const SimpleSlider({
    Key? key,
    required this.slide,
    this.isUpDownAnimation = false,
    this.milliseconds,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration:  Duration(milliseconds: isUpDownAnimation? milliseconds?? 300 : milliseconds?? 1000),
      // reverseDuration: Duration(milliseconds: isUpDownAnimation? upDownMilliseconds : leftRightMilliseconds),
      transitionBuilder: _transitionBuilder,
      child: ClipRect(
        key: slide.key,
        child: Container(
            width: double.infinity,
            child: slide
        ),
      ),

    );
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {

    final inAnimation = isUpDownAnimation?
    Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(animation)
        :
    Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(animation);

    final outAnimation = isUpDownAnimation?
    Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
        .animate(animation) :
    Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(animation);

    if (child.key == slide.key) {
      return ClipRect(
        child: SlideTransition(
          position: inAnimation,
          child: child,
        ),
      );
    } else {
      return ClipRect(
        child: SlideTransition(
          position: outAnimation,
          child: child,
        ),
      );
    }
  }

  Animation<Offset> _downToUpInAnimate(Animation<double> animation) {
    final offsetAnimation = TweenSequence([
      TweenSequenceItem(
          tween: ConstantTween(Offset(0.0, 1.0)), weight: 20),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)),
          weight: 80),
    ]).animate(animation);

    return offsetAnimation;
  }

  Animation<Offset> _rightToLeftInAnimate(Animation<double> animation) {
    final offsetAnimation = TweenSequence([
      TweenSequenceItem(
          tween: ConstantTween(Offset(1.0, 0.0)), weight: 0),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)),
          weight: 100),
    ]).animate(animation);

    return offsetAnimation;
  }

}