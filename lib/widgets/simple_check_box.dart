
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleCheckBox extends StatelessWidget {

  SimpleCheckBox({
    this.isChecked = false,
    this.isRound = false,
    this.size = 20,
    this.onPressed,
    this.isBoldBorder = false,
    this.activeColor
  });

  final bool isChecked;
  final bool isRound;
  final double size;
  final Function(bool)? onPressed;
  final bool isBoldBorder;
  final Color? activeColor;




  @override
  Widget build(BuildContext context) {

    RxBool  isCheckedRx = isChecked? true.obs : false.obs;

    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!(!isCheckedRx.value);
          isCheckedRx.toggle();
        }
      },
      child: Obx(() => Container(
        width: size,
        height: size,
        child: isCheckedRx.isTrue? Icon(Icons.check, size: size - 1, color: Colors.white,) : null,
        decoration: BoxDecoration(
            shape: isRound? BoxShape.circle : BoxShape.rectangle ,
            color: isCheckedRx.isTrue? activeColor?? Theme.of(context).colorScheme.secondary : null,
            border: isCheckedRx.isTrue? null : Border.all(width: isBoldBorder? 0.5 : 1,
                color: Theme.of(context).colorScheme.secondaryVariant),
            borderRadius: isRound? null : BorderRadius.all(Radius.circular(3))
        ),
      )),
    );
  }

}