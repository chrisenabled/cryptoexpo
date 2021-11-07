import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/widgets/my_tab_bar.dart';
import 'package:cryptoexpo/widgets/my_tab_bar_view.dart';
import 'package:cryptoexpo/widgets/trade_duration_group.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/my_nested_scroll_view.dart' as nested;
// import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
    required this.tabCount,
    required this.tabBar,
    required this.tabBarView,
  }) : super(key: key);

  final PreferredSizeWidget tabBar;
  final Widget tabBarView;
  final int tabCount;

  @override
  Widget build(BuildContext context) {
    print('app_tab_bar has been created');

    return DefaultTabController(
        length: tabCount,
        child: NestedScrollView(
          // floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TradeDurationGroup()
                  ],
                ),
                expandedHeight: 60,
                toolbarHeight: 32,
                collapsedHeight: 50,
                pinned: true,
                // bottom: const TradeDurationGroup(),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Column(
                  children: [
                    Text('What is my name'),
                    Text('What is my name'),
                    Text('What is my name'),
                    Text('What is my name'),
                    Text('What is my name'),
                    Text('What is my name'),
                    Text('What is my name'),
                    Text('What is my name'),
                  ],
                ),
              ])),
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  toolbarHeight: 32,
                  pinned: true,
                  bottom: tabBar,
                ),
              )
            ];
          },
          body: tabBarView,
        ));
  }
}

