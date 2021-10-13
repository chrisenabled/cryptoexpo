import 'dart:math';
import 'package:flutter/widgets.dart';

enum FlipDirection {
  VERTICAL,
  HORIZONTAL,
}

class AnimatedFlipper extends StatelessWidget {

  AnimatedFlipper({
    required this.child,
    this.animation,
    this.direction = FlipDirection.HORIZONTAL,
    this.tappable = false,
    this.onTap
  });

  final Widget child;
  final Animation<double>? animation;
  final FlipDirection? direction;
  final bool tappable;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tappable? onTap : null,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          transitionBuilder: _transitionBuilder,
          layoutBuilder: _layoutBuilder,
          child: child,
          switchInCurve: Curves.easeInBack,
          switchOutCurve: Curves.easeInBack.flipped,
        )
    );
  }

  Widget _layoutBuilder(Widget? widget, List<Widget> list) {
    return Stack(children: [widget!, ...list]);
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {

    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);

    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (child.key != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: direction == FlipDirection.HORIZONTAL
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
