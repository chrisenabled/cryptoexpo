

import 'package:flutter/material.dart';

class CircularIconLinkButton extends StatelessWidget {

  const CircularIconLinkButton({
    required this.label,
    required this.icon,
    this.size = 40,
    this.onPressed,
  });

  final String label;
  final Widget icon;
  final double size;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onPressed!(),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle
            ),
            child: Center(child: icon),
          ),
        ),
        SizedBox(height: 13,),
        Text(label, style: Theme.of(context).textTheme.caption!.copyWith(
          fontSize: 12
        ),)
      ],
    );
  }

}