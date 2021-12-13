import 'dart:math';

import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/core/home/signals_screen/signals_controller.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data_model.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:cryptoexpo/modules/models/trading_pair_list_item_model.dart';
import 'package:cryptoexpo/utils/helpers/local_store.dart';
import 'package:cryptoexpo/widgets/trading_pair_list_item.dart';
import 'package:flutter/foundation.dart';
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
                  final coinMeta = followedMarkets[index];
                  // print('signals tabview has ${coinMeta.id}');
                  return TradingPairListItem(
                    key: Key(coinMeta.id!),
                    indicatorName: indicator.name!,
                    isBackgroundBar: isBackgroundBar,
                    coinId: coinMeta.id!,
                    alertDuration: duration,
                    onPressed: onPressed,
                  );
                }, childCount: followedMarkets.length),
              ),
            ),
          ],
        ),
      );
    });
  }
}
