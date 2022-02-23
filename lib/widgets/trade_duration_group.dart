
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'trade_duration.dart';

class TradeDurationGroup extends StatelessWidget implements PreferredSizeWidget {

  const TradeDurationGroup({
    this.selectedIndex = 0,
    required this.onPressed, 
    required this.durations,
  });

  final int selectedIndex;
  final  Function(int) onPressed;
  final List<int> durations;

  @override
  Widget build(BuildContext context) {
    
    RxInt _selectedPos = selectedIndex.obs;

    List<Widget> generateList(int selectedIndex) {
      List<Widget> list = [];
      for (var value in durations) {
        list.add(SizedBox(width: 10,));
        list.add(
            TradeDuration(
              duration: Globals.durationStringMap[value]!,
              isSelected: durations.indexOf(value) == selectedIndex,
              onSelected: (duration) {
                _selectedPos.value = durations.indexOf(value);
                onPressed(durations.indexOf(value));
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