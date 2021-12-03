import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/core/home/home_controller.dart';
import 'package:cryptoexpo/core/home/signals_screen/signals_controller.dart';
import 'package:cryptoexpo/core/home/trending_coins_widget/trending_coins_widget.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:cryptoexpo/widgets/circular_icon_link_bitton.dart';
import 'package:cryptoexpo/widgets/my_tab_bar.dart';
import 'package:cryptoexpo/widgets/news_snippets.dart';
import 'package:cryptoexpo/widgets/signals_tab_bar_view.dart';
import 'package:cryptoexpo/widgets/billboard_ads.dart';
import 'package:cryptoexpo/widgets/trade_duration_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:flutter/widgets.dart';

class Signals extends StatelessWidget {
  const Signals({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print('app_tab_bar has been created');

    return GetBuilder<SignalsController>(
      init: SignalsController(),
      builder: (controller) => DefaultTabController(
        length: Globals.AlertTypes.length,
        child: NestedScrollView(
          // floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TradeDurationGroup(
                        onPressed: (duration) {
                          controller.setDuration(duration);
                        },
                        selectedIndex: controller.getSelectedIndex()
                    )
                  ],
                ),
                expandedHeight: 60,
                toolbarHeight: 32,
                collapsedHeight: 50,
                pinned: true,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      color: Theme.of(context).colorScheme.primaryVariant,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: const TrendingCoinsWidget(),
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )
                            ),
                            child: Column(
                              children: [
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
                                const BillboardAds(
                                    views: [
                                      AssetImage('assets/images/01.png'),
                                      AssetImage('assets/images/02.png'),
                                      AssetImage('assets/images/03.png'),
                                      AssetImage('assets/images/04.png'),
                                      AssetImage('assets/images/05.png'),
                                    ]
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
                                const SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  toolbarHeight: 32,
                  pinned: true,
                  bottom: const MyTabBar(
                    tabs: Globals.AlertTypes,
                    rightButtonText: 'All Orders',
                    rightButtonIcon: Icons.article_outlined,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              )
            ];
          },
          body: Obx(() => SignalsTabBarView(
            isBackgroundBar: controller.isBackgroundBar.value,
            alertTypes: Globals.AlertTypes,
            padding: EdgeInsets.symmetric(horizontal: 15),
            duration: controller.currentDuration.value,
            onPressed: (coinId) {
              HomeController.to.navigateToDerivative(coinId);
            },
          )),
        )),
    );


  }
}

