import 'dart:math';

import 'package:cryptoexpo/modules/models/trading_pair_list_item_model.dart';
import 'package:cryptoexpo/widgets/trading_pair_list_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignalsTabBarViewModel {
  final String tabName;
  final List<SignalListItemModel> items;

  SignalsTabBarViewModel(this.tabName, this.items);
}

class SignalsTabBarView extends StatelessWidget {
  final List<SignalsTabBarViewModel> models;
  final EdgeInsetsGeometry? padding;
  final bool isBackgroundBar;

  const SignalsTabBarView({
    Key? key,
    required this.models,
    this.padding,
    this.isBackgroundBar = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('my_tab_bar_view has been crearted');

    return TabBarView(
        children: models.map((model) {
      return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return buildCustomScrollView(model, context);
            },
          ));
    }).toList());
  }

  Widget buildCustomScrollView(
      SignalsTabBarViewModel model, BuildContext context) {
    int count = (model.items.length);
    return Container(
      padding: padding,
      child: CustomScrollView(
        key: PageStorageKey<String>(model.tabName),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return TradingPairListItem(
                    model: model.items[index],
                  isBackgroundBar: isBackgroundBar,
                );
              }, childCount: count),
            ),
          ),
        ],
      ),
    );
  }
}
