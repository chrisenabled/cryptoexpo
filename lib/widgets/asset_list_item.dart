import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/config/themes/theme_controller.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/asset_model.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AssetListItem extends StatelessWidget {

  const AssetListItem({
    Key? key,
    this.size = 25,
    required this.coinMetaData
  }) : super(key: key);

  final double size;
  final CoinMetaData coinMetaData;

  @override
  Widget build(BuildContext context) {
    return _buildAssetListItem(context);
    // return GetBuilder<CoinController>(
    //   tag: coinMetaData.id,
    //   builder: (controller) => _buildAssetListItem(context, controller),
    // );
  }


  Widget _buildAssetListItem(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    final asset = myLoadAsset(
        'assets/images/${coinMetaData.id!.toLowerCase()}.png');

    // final priceData = controller.coinData.value?.priceData;
    //
    // num price24hrChange = Globals.zeroMoney;
    //
    // if(priceData != null && priceData.usd24hChange != null) {
    //   price24hrChange = double.parse((priceData.usd24hChange)!.toStringAsFixed(2));
    // }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(0, -4),
              child: FutureBuilder<String?>(
                  future: asset,
                  builder: (BuildContext context,
                      AsyncSnapshot<String?> snapshot) {
                    if (snapshot.hasData) {
                      return Image.asset(
                        snapshot.data!,
                        width: size,
                        height: size,
                      );
                    } else {
                      return Image.asset(
                        Globals.imgPlaceHolder64Path,
                        width: size,
                        height: size,
                      );
                    }
                  }),
            ),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coinMetaData.symbol!.toUpperCase(),
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
                  '(${coinMetaData.name!})',
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 13,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .secondaryVariant,
                  ),
                )
              ],
            ),
          ],
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       '${priceData?.usd?? Globals.zeroMoney}',
        //       style: textTheme.bodyText1!.copyWith(
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     SizedBox(height: 4,),
        //     Text(
        //       '$price24hrChange',
        //       style: textTheme.caption!.copyWith(
        //           fontSize: 13,
        //           color: price24hrChange < 0
        //               ? MyColors.downTrendColor
        //               : price24hrChange == 0
        //               ? Theme.of(context).colorScheme.secondaryVariant
        //               : MyColors.upTrendColor
        //       ),
        //     )
        //   ],
        // )
      ],
    );
  }

}