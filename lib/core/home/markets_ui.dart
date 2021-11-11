

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/widgets/simple_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketsUI extends StatelessWidget {

  const MarketsUI();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MarketsGridView(
          markets: Markets.values.map((market) => market.string).toList(),
        ),
      ),
    );
  }

}

class MarketsGridView extends StatelessWidget {

  MarketsGridView({
    required this.markets
  });

  final List<String> markets;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 2.4,
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      //
      children: markets.map((market)  {
        return MarketTile(market: market);
      }).toList(),
    );
  }

}

class MarketTile extends StatelessWidget {

  const MarketTile({
    this.isSelected = false,
    this.onPressed,
    required this.market,
  });

  final bool isSelected;
  final String market;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {

    final RxBool isSelectedRx = isSelected.obs;

    return GestureDetector(
      onTap: () {
        isSelectedRx.toggle();
        onPressed!();
      },
      child: Obx(() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(market,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.1, 0.1),
                        blurRadius: 0.1,
                        color: MyColors.richBlack,
                      )
                    ],
                  ),
                ),
                Text('Spot', style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),),
              ],
            ),
            SimpleCheckBox(
              size: 12.5,
              isRound: true,
              isChecked: isSelectedRx.value,
            ),
          ],
        ),
      )),
    );
  }

}