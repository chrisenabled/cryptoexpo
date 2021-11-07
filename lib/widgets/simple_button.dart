

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SimpleButton extends StatelessWidget {

  SimpleButton({
    this.text = '',
    required this.onPressed,
    this.icon,
    this.isEnabled = true,
    this.margin,
    this.removeMargin = false

  });

  final String text;
  final Function() onPressed;
  final IconData? icon;
  final bool isEnabled;
  final EdgeInsetsGeometry? margin;
  final bool removeMargin;



  @override
  Widget build(BuildContext context) {

    RxBool isPressed = false.obs;

    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        if(isPressed.isFalse && isEnabled) {
          onPressed();
          isPressed.value = true;
        }
      },
      child: Obx(() {

        Color getContentColor() {
          return isPressed.isTrue? Colors.white12 :
          isEnabled? Colors.white : Colors.grey;
        }

        List<Widget> contents() {
          List<Widget> widgets = [];
          if(text.length > 0) widgets.add(
              Text(text, style: textTheme.bodyText1!.copyWith(
                  color: getContentColor(),
                  fontWeight: FontWeight.bold
              ),)
          );
          if(text.length > 0 && icon != null) widgets.add(SizedBox(width: 10,));

          if(icon != null) widgets.add(Icon(icon, color: getContentColor(),));

          return widgets;
        }

        return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        margin: margin != null ? margin : removeMargin ? null : EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isPressed.isTrue? Theme.of(context).colorScheme.secondary.withOpacity(0.4) :
              isEnabled? Theme.of(context).colorScheme.secondary :
              Theme.of(context).colorScheme.secondaryVariant.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: contents(),
        ),
      );
      }),
    );
  }

}