

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/modules/models/asset_model.dart';
import 'package:flutter/material.dart';

class AssetListItem extends StatelessWidget {

  const AssetListItem({
    Key? key,
    required this.asset,
    this.size = 24
  }): super(key: key);

  final Asset asset;
  final double size;

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
                asset.iconAsset,
                width: size,
                height: size,
              ),
            ),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.assetTicker,
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
                  '(${asset.assetName})',
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
              '${asset.currentPrice}',
              style: textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4,),
            Text(
              '${asset.percentage}%',
              style: textTheme.caption!.copyWith(
                fontSize: 13,
                color: asset.percentage < 0? MyColors.downTrendColor :
                asset.percentage == 0? Theme.of(context).colorScheme.secondaryVariant :
                        MyColors.upTrendColor
              ),
            )
          ],
        )
      ],
    );
  }

}