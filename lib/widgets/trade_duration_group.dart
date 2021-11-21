
import 'package:cryptoexpo/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'trade_duration.dart';

class TradeDurationGroup extends StatelessWidget implements PreferredSizeWidget {

  const TradeDurationGroup({
    this.selectedIndex = 0,
    required this.onPressed,
  });

  final int selectedIndex;
  final  Function(int) onPressed;

  @override
  Widget build(BuildContext context) {

    RxInt _selectedPos = selectedIndex.obs;

    List<Widget> generateList(int selectedIndex) {
      List<Widget> list = [];
      for (var value in TradePeriod.values) {
        if(value.index != 0) list.add(SizedBox(width: 10,));
        list.add(
            TradeDuration(
              duration: value.string,
              isSelected: value.index == selectedIndex,
              onSelected: (duration) {
                onPressed(value.number);
                _selectedPos.value = value.index;
              },
            ));
      }
      return list;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: generateList(_selectedPos.value)
      )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);

}