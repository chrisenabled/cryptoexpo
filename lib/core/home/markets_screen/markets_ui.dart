import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:cryptoexpo/core/home/markets_screen/markets_controller.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/widgets/my_tab_bar.dart';
import 'package:cryptoexpo/widgets/simple_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketsUI extends StatelessWidget {
  const MarketsUI();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketsController>(
        init: MarketsController(),
        builder: (controller) => SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MyTabBar(
                              tabs: ['All', 'Following'],
                              isCapsuleStyle: true,
                              isScrollable: false),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  MarketsGridView(
                                    controller: controller,
                                  ),
                                  MarketsGridView(
                                    isFavorites: true,
                                    controller: controller,
                                    autoUpdate: true,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    )),
              ),
            ));
  }
}

class MarketsGridView extends StatelessWidget {
  MarketsGridView({
    this.isFavorites = false,
    required this.controller,
    this.autoUpdate = false,
  });

  final bool isFavorites;
  final MarketsController controller;
  final bool autoUpdate;

  @override
  Widget build(BuildContext context) {
    return autoUpdate
        ? Obx(() => _buildGridView(controller.followedMarkets.value!))
        : _buildGridView(controller.allCoinMetas);
  }

  GridView _buildGridView(List<CoinMetaData> markets) {
    return GridView.count(
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      childAspectRatio: 1.3,
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      //
      children: markets.map((market) {
        final CoinMetaData? sameMarket = controller.followedMarkets.value!
            .firstWhere((mk) => mk.symbol == market.symbol,
                orElse: () => CoinMetaData());

        return MarketTile(
          isSelected: sameMarket?.symbol != null,
          market: market,
          onPressed: () {
            if (sameMarket?.symbol != null) {
              controller.removeFollowedMarket(market);
            } else {
              controller.saveFollowedMarket(market);
            }
          },
        );
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
  final CoinMetaData market;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {

    final RxBool isSelectedRx = isSelected.obs;

    return GetBuilder<CoinController>(
        tag: market.id,
        builder: (controller) {

          var percentage24Change = controller.coinData.value
              ?.coinMarketData
              ?.priceChangePercentage24h;
          percentage24Change = percentage24Change?.toDecimalNumber(2);

          Color getPercentageColor() {
            if(percentage24Change == null || percentage24Change == 0.00) {
              return Theme.of(context).colorScheme.onPrimary;
            }
            if(percentage24Change > 0) {
              return MyColors.upTrendColor;
            } else {
              return MyColors.downTrendColor;
            }
          }

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
                // borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: '${market.symbol!.toUpperCase()}',
                              style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.1, 0.1),
                                    blurRadius: 0.1,
                                    color: MyColors.richBlack,
                                  )
                                ],
                              ),
                              children: [
                                TextSpan(
                                  text: ' /USD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5
                                  ),
                                )
                              ]),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Text(
                            market.name!,
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).colorScheme.secondaryVariant,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('${controller.coinData.value?.priceData?.usd}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: Text(percentage24Change != null
                            ? '$percentage24Change%' : '. . .',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: getPercentageColor(),
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.1, 0.1),
                                blurRadius: 0.1,
                                color: MyColors.richBlack,
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SimpleCheckBox(
                          size: 18,
                          isRound: true,
                          isChecked: isSelectedRx.value,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          );
        }
    );
  }
}
