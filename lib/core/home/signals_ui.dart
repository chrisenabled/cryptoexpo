import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/widgets/circular_icon_link_bitton.dart';
import 'package:cryptoexpo/widgets/crypto_list_item.dart';
import 'package:cryptoexpo/widgets/my_tab_bar.dart';
import 'package:cryptoexpo/widgets/news_snippets.dart';
import 'package:cryptoexpo/widgets/signals_tab_bar_view.dart';
import 'package:cryptoexpo/widgets/billboard_ads.dart';
import 'package:cryptoexpo/widgets/trade_duration_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/async.dart';

import '../../widgets/my_nested_scroll_view.dart' as nested;
// import 'package:flutter/widgets.dart';

class Signals extends StatelessWidget {
  const Signals({
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

    // final cd = CountdownTimer(Duration(seconds: 70), Duration(seconds: 5));
    //
    // cd.listen((data) {
    //   news.value = '${news.value} ${cd.elapsed.inSeconds}';
    // }, onDone: () {
    //   cd.cancel();
    // });

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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      const BillboardAds(
                          views: [
                            Text('The page number is: 1'),
                            Text('The page number is: 2'),
                            Text('The page number is: 3'),
                            Text('The page number is: 4'),
                            Text('The page number is: 5'),
                          ]
                      ),
                      const SizedBox(height: 20,),
                      const NewsSnippets(
                        news: [
                          'The page number is: 1',
                          'The page number is: 2',
                          'The page number is: 3',
                          'The page number is: 4',
                          'The page number is: 5',
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const CircularIconLinkButton(
                              label: 'Rewards',
                              icon: Icon(CupertinoIcons.bolt_badge_a_fill, color: Colors.green,),
                          ),
                          const CircularIconLinkButton(
                              label: 'Alerts',
                              icon: Icon(CupertinoIcons.bell_fill, color:  Colors.pinkAccent,),
                          ),
                          const CircularIconLinkButton(
                              label: 'Invite Friends',
                              icon: Icon(CupertinoIcons.person_badge_plus_fill, color: Colors.lightBlueAccent,),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 30,),
                      // const CryptoListItem(
                      //     cryptoName: 'Bitcoin',
                      //     cryptoTicker: 'BTC',
                      //     iconAsset: 'assets/images/btc.png'
                      // ),
                      // const SizedBox(height: 30,),
                      // const CryptoListItem(
                      //     cryptoName: 'Action Coin',
                      //     cryptoTicker: 'ACTN',
                      //     iconAsset: 'assets/images/actn.png'
                      // ),
                      const SizedBox(height: 30,),
                    ],
                  ),
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

