

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/widgets/animated_flipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BullBearIcon extends StatelessWidget {

  BullBearIcon({
    required this.isBullRun,
    required this.bgColor,
    required this.iconSize,
  });

  final bool isBullRun;
  final Color bgColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipper(child: isBullRun? bullWidget() : bearWidget());
  }

  Widget bullWidget() {
    return Container(
        key: Key('bull'),
        decoration: new BoxDecoration(
          color: AppThemes.whiteLilac
        ),
        child: Icon(
          Icons.favorite,
          color: Colors.pink,
          size: iconSize,
          semanticLabel: 'Text to announce in accessibility modes',
        )
    );
  }

Widget bearWidget() {
  return Container(
      key: Key('bear'),
      decoration: new BoxDecoration(
          color: AppThemes.whiteLilac
      ),
      child: Icon(
        Icons.ac_unit,
        color: Colors.blue,
        size: iconSize,
        semanticLabel: 'Text to announce in accessibility modes',
      )
  );
}

}