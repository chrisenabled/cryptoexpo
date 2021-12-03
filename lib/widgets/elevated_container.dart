

import 'package:flutter/material.dart';

class ElevatedContainer extends StatelessWidget {

  ElevatedContainer({
    required this.child,
    this.borderRadius = 5.0,
    this.offset,
    this.blurRadius = 2.0,
    this.containerColor,
    this.shadowColor,
  });

  final Widget child;
  final double borderRadius;
  final double blurRadius;
  final Offset? offset;
  final Color? containerColor;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        child: child,
        margin: EdgeInsets.only(bottom: blurRadius), //Same as `blurRadius` i guess
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: containerColor?? Colors.white,
          boxShadow: [
            BoxShadow(
              color: shadowColor??  Colors.grey,
              offset: offset ?? Offset(0.0, 0.3), //(x,y)
              blurRadius: blurRadius,
            ),
          ],
        ),
      ),
    );
  }

}