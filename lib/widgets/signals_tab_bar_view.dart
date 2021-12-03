import 'dart:math';

import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/core/home/signals_screen/signals_controller.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data_model.dart';
import 'package:cryptoexpo/modules/models/trading_pair_list_item_model.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:cryptoexpo/widgets/trading_pair_list_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignalsTabBarViewModel {
  final String tabName;
  final List<SignalListItemModel> items;

  SignalsTabBarViewModel(this.tabName, this.items);
}

class SignalsTabBarView extends StatelessWidget {
  final List<String> alertTypes;
  final EdgeInsetsGeometry? padding;
  final bool isBackgroundBar;
  final num duration;
  final Function(String)? onPressed;

  const SignalsTabBarView(
      {Key? key,
      required this.alertTypes,
      this.padding,
      this.isBackgroundBar = false,
      this.duration = 5,
        this.onPressed,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('my_tab_bar_view has been crearted');

    return TabBarView(
        children: alertTypes.map((type) {
      return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return GetBuilder<SignalsController>(
                  builder: (controller) =>
                      buildCustomScrollView(type, context, controller)
              );
            },
          ));
    }).toList());
  }

  Widget buildCustomScrollView(String type, BuildContext context,
      SignalsController controller ) {
    List<CoinMetaData> coinMetas = controller.followedMarkets.value!;
    return Container(
      padding: padding,
      child: CustomScrollView(
        key: PageStorageKey<String>(type),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                final coinMeta = coinMetas[index];
                print('signals tabview has ${coinMeta.id}');
                return TradingPairListItem(
                  key: Key(coinMeta.id!),
                  alertType: type,
                  isBackgroundBar: isBackgroundBar,
                  coinId: coinMeta.id!,
                  alertDuration: duration,
                  onPressed: onPressed,
                );
              }, childCount: coinMetas.length),
            ),
          ),
        ],
      ),
    );
  }
}
