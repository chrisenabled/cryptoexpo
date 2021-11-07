

import 'package:flutter/material.dart';

class TradeDuration extends StatelessWidget {

  TradeDuration({
    required this.duration,
    this.isSelected = false,
    required this.onSelected,
  });

  final String duration;
  final bool isSelected;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(duration),
      child: Container(
        width: 50,
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(

            border: Border.all(
              width: 1.5,
              color: isSelected? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.secondaryVariant,
            ),
            borderRadius: BorderRadius.circular(3)
        ),
        child: SizedBox.expand(
          child: Text(
            '$duration',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSelected? FontWeight.bold : FontWeight.normal,
              color: isSelected? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.secondaryVariant,
            ),
          ),
        ),
      ),
    );
  }

}