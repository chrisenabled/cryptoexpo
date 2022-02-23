
import 'package:cryptoexpo/core/home/signals_screen/signals_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:cryptoexpo/widgets/trade_calls_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignalsTabBarView extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final bool isBackgroundBar;
  final Function(String)? onPressed;
  final List<CoinMetaData> followedMarkets;

  const SignalsTabBarView({
    Key? key,
    this.padding,
    this.isBackgroundBar = false,
    this.onPressed,
    required this.followedMarkets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignalsController>(
        builder: (controller) => TabBarView(
              children: controller.indicators!.map((indicator) {
                return SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(
                      builder: (BuildContext context) {
                        return buildCustomScrollView(
                            indicator, context, controller);
                      },
                    ));
              }).toList(),
            ));
  }

  Widget buildCustomScrollView(SignalIndicator indicator, BuildContext context,
      SignalsController controller) {
    return Obx(() {
      final num duration = indicator.durationsInMin![
          controller.selectedDurationIndexPerIndicator[indicator.name!]!.value
      ];

      List<CoinMetaData> _followedMarkets = List.from(followedMarkets);

      if(indicator.includeTickers.length > 0) {
        _followedMarkets = _followedMarkets.where((element) =>
            indicator.includeTickers.contains(element.symbol))
            .toList().cast<CoinMetaData>();
      }

      if(_followedMarkets.length == 0 ) {
        return Center(
          child: Text('No Derivative Followed'),
        );
      }

      return Container(
        padding: padding,
        child: CustomScrollView(
          key: PageStorageKey<String>(indicator.name!),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final coinMeta = _followedMarkets[index];
                  // print('signals tabview has ${coinMeta.id}');
                  return TradeCallsListItem(
                    key: Key(coinMeta.id!),
                    indicatorName: indicator.name!,
                    isBackgroundBar: isBackgroundBar,
                    coinId: coinMeta.id!,
                    alertDuration: duration,
                    onPressed: onPressed,
                  );
                }, childCount: _followedMarkets.length),
              ),
            ),
          ],
        ),
      );
    });
  }
}
