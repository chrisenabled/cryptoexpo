import 'package:cryptoexpo/widgets/elevated_container.dart';
import 'package:cryptoexpo/widgets/trending_coin_view.dart';
import 'package:quiver/iterables.dart';

import 'trending_coins_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendingCoinsWidget extends StatelessWidget {
  const TrendingCoinsWidget({this.size = 100});

  final double size;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingCoinsController>(
        init: TrendingCoinsController(),
        builder: (controller) {
          final pages = _buildCoinPages(controller);

          return ElevatedContainer(
            containerColor: Theme.of(context).colorScheme.primary,
            shadowColor: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                // Container(
                //   padding: const EdgeInsets.all(3),
                //   child: Text(
                //     'Trending',
                //     style: Theme.of(context).textTheme.caption,
                //   ),
                // ),
                SizedBox(
                  height: size,
                  child: Stack(
                    children: [
                      PageView(
                        controller: controller.pageController,
                        children: pages,
                        onPageChanged: (page) => controller.onPageChanged(page),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Obx(() =>
                            _buildIndicator(pages, controller.currentPage.value)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildIndicator(
    List<Widget> pages,
    int pageNo,
  ) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: pages.asMap().entries.map((entry) {
          final isPage = entry.key == pageNo;
          return Text(
            '\u2014',
            style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
                fontWeight: isPage ? FontWeight.bold : FontWeight.normal,
                color: isPage
                    ? Theme.of(Get.context!).colorScheme.onPrimary
                    : Theme.of(Get.context!).colorScheme.secondaryVariant),
          );
        }).toList());
  }

  List<Widget> _buildCoinPages(TrendingCoinsController controller) {
    final emptyRows = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('- - -'),
        Text('- - -'),
        Text('- - -'),
      ],
    );

    if (controller.trendingCoins.isEmpty) {
      return [emptyRows, emptyRows, emptyRows];
    }

    final coinsChunks = partition(controller.trendingCoins, 3);

    final List<Widget> pages = [];

    coinsChunks.forEach((coins) {
      final List<Widget> items = [];
      coins.forEach((coin) {
        items.add(
            Flexible(
                flex: 3,
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.all(8.0),
                    child: TrendingCoinView(coin: coin)
                )
            )
        );
      });

      final row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items,
      );

      pages.add(row);

    });

    return pages;
  }
}
