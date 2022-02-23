import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/core/home/home_controller.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/trade_calls_store.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:cryptoexpo/utils/ui/widgets.dart';
import 'package:cryptoexpo/widgets/trade_call_msg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class TradeCallView extends StatelessWidget {
  TradeCallView({
    required this.store,
    this.isAlternateDesign = false,
    required this.controller
  });

  final TradeCallStore store;
  final bool isAlternateDesign;
  final CoinController controller;

  @override
  Widget build(BuildContext context) {
    final percentage = tradeCallCurrentProfit(store, controller);

    final style = Theme.of(context).textTheme.bodyText2!.copyWith(
      fontWeight: FontWeight.bold,);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5.0,
            width: double.infinity,
            color: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '• ${store.coinId!} •',
                style: style,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Indicator: ', style: style,),
                        Text('${store.indicatorName}'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Duration: ', style: style,),
                        Text('${Globals.durationStringMap[store.duration]}'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Profit: ', style: style,),
                        Text(
                          percentage > 0 ? '+$percentage%' : '$percentage%',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: getTrendColor(context, percentage)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    HomeController.to.navigateToDerivative(store.coinId!);
                  },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text('• • •'),
                    )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          Expanded(
              child: ListView(
            children: store.calls.reversed
                .map((e) {

                  String time = timeago.format(e.time!, locale: 'en_short');

                  if(time != 'now') {
                    time = time + ' ago';
                  }

                  return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TradeCallSignalMsgWidget(
                            message: e.alertMsg,
                            isAlternateDecoration: isAlternateDesign,
                          ),
                          Text('\$${e.price}'),
                          Text('$time'),
                        ],
                      ),
                  );
                })
                .toList(),
          ))
        ],
      );
  }
}
