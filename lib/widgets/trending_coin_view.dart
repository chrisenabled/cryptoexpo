

import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class TrendingCoinView extends StatelessWidget {

  TrendingCoinView({
    required this.coin
  });

  final CoinMetaData coin;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinController>(
      tag: 'trending-${coin.id}',
        builder: (controller) {
        var priceChange24 =
            controller.coinData.value!
                .coinMarketData?.priceChangePercentage24h
                ?? 0.0;
        priceChange24 = num.parse(priceChange24.toStringAsFixed(2));

           return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(controller.coinMeta.id)!.toUpperCase()}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.clock,
                      size: 10,
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                    SizedBox(width: 3,),
                    Text(
                      '$priceChange24%',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        color: getTrendColor(priceChange24, context)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3,),
                Text(
                  '${controller.coinData.value?.priceData?.usd?? '- - -'}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: getTrendColor(controller.priceDifference, context)
                  ),
                ),
                SizedBox(height: 3,),
                _buildSparkLine(
                    controller.coinData.value?.coinMarketData, context),
              ],
            );
      }

    );
  }

  Widget _buildSparkLine(CoinMarketData? marketData, BuildContext context) {
    if(marketData == null
        || marketData.sparkLineIn7d == null
        || marketData.sparkLineIn7d!.isEmpty ) {
      return Text('- - -');
    }

    Map<int, num> data = marketData.sparkLineIn7d!.asMap();


    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        //Initialize the spark charts widget
        child: SfSparkLineChart.custom(
          //Enable data label
          xValueMapper: (int index) => data[index],
          yValueMapper: (int index) => data.keys.elementAt(index),
          dataCount: 5,
          axisLineColor: Colors.transparent,
          color: getTrendColor(
              data[data.length - 1]! - data[0]!, context),
        ),
      ),
    );
  }

}