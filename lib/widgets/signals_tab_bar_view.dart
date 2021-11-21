import 'dart:math';

import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data_model.dart';
import 'package:cryptoexpo/modules/models/trading_pair_list_item_model.dart';
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

  const SignalsTabBarView(
      {Key? key,
      required this.alertTypes,
      this.padding,
      this.isBackgroundBar = false,
      this.duration = 5})
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
              return buildCustomScrollView(type, context);
            },
          ));
    }).toList());
  }

  Widget buildCustomScrollView(String type, BuildContext context) {
    List<CoinMetaData> coinMetas = Get.find();
    int count = coinMetas.length;
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
                return TradingPairListItem(
                  key: Key(coinMeta.id!),
                  alertType: type,
                  isBackgroundBar: isBackgroundBar,
                  coinId: coinMeta.id!,
                  alertDuration: duration,
                );
              }, childCount: count),
            ),
          ),
        ],
      ),
    );
  }
}
