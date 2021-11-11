

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:flutter/material.dart';

class CryptoListItem extends StatelessWidget {

  const CryptoListItem({
    Key? key,
    required this.cryptoName,
    required this.cryptoTicker,
    required this.iconAsset,
    this.currentPrice = 0.000000,
    this.percentage = 0.00
  }): super(key: key);

  final String cryptoName;
  final String cryptoTicker;
  final String iconAsset;
  final double currentPrice;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(0, -4),
              child: Image.asset(
                iconAsset,
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cryptoTicker,
                  style: textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.1, 0.1),
                        blurRadius: 0.1,
                        color: MyColors.richBlack,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  '($cryptoName)',
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                )
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$currentPrice',
              style: textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4,),
            Text(
              '$percentage%',
              style: textTheme.caption!.copyWith(
                fontSize: 13,
                color: percentage < 0? MyColors.downTrendColor :
                    percentage == 0? Theme.of(context).colorScheme.secondaryVariant :
                        MyColors.upTrendColor
              ),
            )
          ],
        )
      ],
    );
  }

}