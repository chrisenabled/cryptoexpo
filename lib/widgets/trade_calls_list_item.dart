import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/config/themes/theme_controller.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/trade_calls_store.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:cryptoexpo/utils/ui/widgets.dart';
import 'package:cryptoexpo/widgets/trade_call_msg_widget.dart';
import 'package:cryptoexpo/widgets/trade_call_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TradeCallsListItem extends StatelessWidget {
  final String indicatorName;
  final bool isBackgroundBar;
  final String coinId;
  final num alertDuration;
  final Function(String)? onPressed;

  const TradeCallsListItem({
    Key? key,
    required this.indicatorName,
    this.isBackgroundBar = true,
    required this.coinId,
    this.alertDuration = 5,
    this.onPressed,
  }) : super(key: key);

  bool showIconForSignalMsg(String? msg) {
    if (msg == null) return false;
    return ['bear', 'bull', 'uptrend', 'downtrend'].contains(msg.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {

    final tradeCallStore = TradeCallStore(
            coinId: coinId,
            indicatorName: indicatorName,
            duration: alertDuration)
        .obs;

    final Rx<num> monthPerformance = 0.0.obs;

    return GetBuilder<CoinController>(
      id: '$coinId$indicatorName$alertDuration',
      tag: coinId,
      builder: (controller) {

        controller.tradeCallStoreUpdate(tradeCallStore.value.storeKey,
            (newStore) {
          tradeCallStore.value = newStore;
        });

        controller.historyUpdate(tradeCallStore.value.historyKey,
                (aggregatePercent) {
          monthPerformance.value = aggregatePercent;
        });

        return Obx(() {
          num percentage =
          tradeCallCurrentProfit(tradeCallStore.value, controller);
          return  GestureDetector(
              onTap: () {
                if (onPressed != null) {
                  // onPressed!(coinId);
                }
                _showFullTradeCalls(context, tradeCallStore, controller);
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Stack(
                    children: [
                      if (isBackgroundBar)
                        Positioned.fill(
                          child: _fullPriceProgressIndicator(percentage),
                        ),
                      Container(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.8),
                        padding: const EdgeInsets.only(
                            left: 4, top: 2, bottom: 2, right: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: _pairInfoColumn(
                                            context, controller),
                                        flex: 4,
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: _priceColumn(
                                              context,
                                              controller,
                                              tradeCallStore.value)),
                                      Expanded(
                                          flex: 2,
                                          child: _signalMsg(tradeCallStore)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _xAmount(context, controller),
                                      _miniPriceProgressIndicator(
                                          context, percentage),
                                      _percentageDiff(context, percentage)
                                    ],
                                  ),
                                  _monthPerformance(context, monthPerformance),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            );
        });
      },
    );
  }

  Future<dynamic> _showFullTradeCalls(BuildContext context,
      Rx<TradeCallStore> tradeCallStore, CoinController controller) async {
    return showModalBottomSheet(
        // isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Obx(() {
            if (tradeCallStore.value.calls.length == 0) {
              return Center(
                child: Text('No Calls yet'),
              );
            }
            return TradeCallView(
              store: tradeCallStore.value,
              isAlternateDesign: isBackgroundBar,
              controller: controller,
            );
          });
        });
  }

  Widget _signalMsg(Rx<TradeCallStore> tradeCallStore) {
    String? msg = '';
    final store = tradeCallStore.value;
    if (store.calls.length > 0) {
      final signalAlerts = store.calls;
      msg = signalAlerts[signalAlerts.length - 1].alertMsg;
    }
    return TradeCallSignalMsgWidget(
      isAlternateDecoration: isBackgroundBar,
      message: msg,
      counter: store.consecutiveLastCall > 1 ? store.consecutiveLastCall : 0,
    );
  }

  Widget _monthPerformance(BuildContext context, Rx<num> performancePercent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('month performance: ',
            style: Theme.of(context).textTheme.caption!),
        Obx(
          () => Text(
            '$performancePercent%',
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: getTrendColor(context, performancePercent.value),
                fontSize: 10.0),
          ),
        ),
      ],
    );
  }

  Widget _percentageDiff(BuildContext context, num percentage) {
    return Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: Text(
            percentage > 0 ? '+$percentage%' : '$percentage%',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.caption!.copyWith(
              // fontWeight: FontWeight.bold,
              fontSize: 10,
              color: getTrendColor(context, percentage),
              // letterSpacing: 1,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.1, 0.1),
                  blurRadius: 0.1,
                  color: getTrendColor(context, percentage),
                )
              ],
            ),
          ),
        ));
  }

  Widget _miniPriceProgressIndicator(BuildContext context, num percentage) {
    final widthFactor =
        getPercentageChangeProgress(percentage: percentage) / 100;

    return Expanded(
        flex: 6,
        child: isBackgroundBar
            ? Container()
            : Container(
                height: 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ThemeController.to.isDarkModeOn
                      ? Colors.white12
                      : Colors.black12,
                ),
                child: FractionallySizedBox(
                  alignment: percentage > 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  widthFactor: widthFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: getTrendColor(context, percentage),
                    ),
                  ),
                ),
              ));
  }

  Widget _xAmount(BuildContext context, CoinController controller) {
    final percentageX = controller.getPercentageX();
    return Expanded(
        flex: 2,
        child: percentageX.abs() < 1
            ? Text(
                Globals.emptyText,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.caption,
              )
            : Text(
                '${percentageX}x',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ));
  }

  Widget _pairInfoColumn(BuildContext context, CoinController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${controller.coinMeta.symbol?.toUpperCase()}${Globals.usdDerivative}',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.3, 0.3),
                blurRadius: 0.3,
                color: Theme.of(context).colorScheme.secondaryVariant,
              )
            ],
          ),
        ),
        Text(
          '${controller.coinMeta.symbol}',
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }

  Widget _priceColumn(
      BuildContext context, CoinController controller, TradeCallStore store) {
    CoinDataModel coin = controller.coinData.value!;
    num price = (coin.priceData?.usd) ?? Globals.zeroMoney;
    num initPrice = 0.0;

    if (store.calls.length > 0) {
      initPrice = store.calls.first.price ?? 0.0;
    }

    return Row(
      mainAxisAlignment: price == Globals.zeroMoney
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$$price',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                    color: price - controller.oldPrice == 0
                        ? Theme.of(context).colorScheme.onPrimary
                        : price - controller.oldPrice > 0
                            ? MyColors.upTrendColor
                            : MyColors.downTrendColor)),
            RichText(
              text: TextSpan(
                  text: '$initPrice',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 11, letterSpacing: 0.5),
                  children: [
                    TextSpan(
                      text: ' USD',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 9, letterSpacing: 0.0),
                    )
                  ]),
            )
          ],
        ),
      ],
    );
  }

  Widget _fullPriceProgressIndicator(num percentage) {
    final widthFactor =
        (getPercentageChangeProgress(percentage: percentage) / 100).abs();
    return Container(
      child: FractionallySizedBox(
        alignment: percentage > 0 ? Alignment.topLeft : Alignment.topRight,
        widthFactor: widthFactor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: percentage > 0 || percentage.abs() >= 99.8
                    ? Radius.circular(3)
                    : Radius.circular(0),
                topRight: percentage < 0 || percentage.abs() >= 99.8
                    ? Radius.circular(3)
                    : Radius.circular(0),
                bottomLeft: percentage > 0 || percentage.abs() >= 99.8
                    ? Radius.circular(3)
                    : Radius.circular(0),
                bottomRight: percentage < 0 || percentage.abs() >= 99.8
                    ? Radius.circular(3)
                    : Radius.circular(0)),
            color: percentage > 0
                ? MyColors.upTrendColor
                : MyColors.downTrendColor,
          ),
        ),
      ),
    );
  }
}
