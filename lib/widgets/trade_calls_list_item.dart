import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/config/themes/theme_controller.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/trade_calls_store.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'animated_flip_counter.dart';

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

  bool isWidget(String? msg) {
    if (msg == null) return false;
    return msg == 'bear' || msg == 'bull';
  }

  Color getTrendColor(BuildContext context, num percentage) {
    return percentage == 0
        ? Theme.of(context).colorScheme.secondaryVariant
        : percentage > 0
            ? MyColors.upTrendColor
            : MyColors.downTrendColor;
  }

  // Future<void> executeAfterBuild(BuildContext context) async {
  //   // this code will get executed after the build method
  //   // because of the way async functions are scheduled
  // }

  @override
  Widget build(BuildContext context) {
    Rx<num> monthPerformance = 0.0.obs;
    // Rx<double> contentHeight = 40.0.obs;
    //
    // WidgetsBinding.instance?.addPostFrameCallback((_) => () {
    //   contentHeight.value = context.height;
    // });

    return GetBuilder<CoinController>(
      // id: Key(indicatorTypeTag),
      tag: coinId,
      builder: (controller) {

        final tradeCallStore = controller.tradeCallStores.firstWhereOrNull(
            (store) => (store.value.duration == alertDuration &&
                store.value.indicatorName == indicatorName));

        final historyKey = tradeCallStore?.value.historyKey
            ?? coinId + indicatorName + '$alertDuration';

        controller.historyUpdate(historyKey, (aggregatePercent) {
          monthPerformance.value = aggregatePercent;
        });
        num percentage = 0.0;

        if(tradeCallStore!.value.calls.length > 0) {
          final current = controller.coinData.value?.priceData?.usd?? 0.0;
          final initial = tradeCallStore.value.calls.first.price?? 0.0;
          percentage = getPercentageDiff(initial: initial, current: current);
        }



        return GestureDetector(
          onTap: () {
            if (onPressed != null) {
              onPressed!(coinId);
            }
          },
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Stack(
                children: [
                  if (isBackgroundBar)
                    Positioned.fill(
                      child: _fullPriceProgressIndicator(controller),
                    ),
                  Container(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
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
                                    child: _pairInfoColumn(context, controller),
                                    flex: 4,
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: _priceColumn(context, controller)),
                                  Expanded(
                                      flex: 2,
                                      child: Obx(() {
                                        return _signalContainer(
                                            context, tradeCallStore.value);
                                      })),
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
      },
    );
  }

  Widget _monthPerformance(BuildContext context, Rx<num> performancePercent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('month performance: ',
          style: Theme.of(context).textTheme
              .caption!),

        Obx(() =>
            Text(
              '$performancePercent%',
              style: Theme.of(context).textTheme
                  .caption!
                  .copyWith(
                  color: getTrendColor(context,
                      performancePercent.value
                  )
              ),
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

  Widget _miniPriceProgressIndicator(
      BuildContext context, num percentage) {
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

  Widget _signalContainer(BuildContext context, TradeCallStore? alertStore) {
    String? msg = '';

    if (alertStore?.calls != null) {
      if (alertStore!.calls.length > 0) {
        final signalAlerts = alertStore.calls;
        msg = signalAlerts[signalAlerts.length - 1].alertMsg;
      }
    }
    // printInfo(info: 'alertStore:  ${alertStore?.type}'
    //     ' ${alertStore?.duration} ${alertStore?.signalAlerts?.length}');

    // printInfo(info: 'the alert msg received by $coinId is  $msg');

    bool isAlternateDecoration() {
      return isBackgroundBar || msg == 'bull' || msg == 'bear';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: isAlternateDecoration()
                    ? null
                    : msg!.isEmpty
                        ? Theme.of(context).colorScheme.surface
                        : Globals.upTrendMsgList.contains(msg)
                            ? MyColors.upTrendColor
                            : MyColors.downTrendColor,
              ),
              child: msg!.isEmpty
                  ? Text(Globals.emptyText)
                  : isWidget(msg)
                      ? Lottie.asset(
                          'assets/lottie/${msg}_run.json',
                          height: 36,
                        )
                      : Text(
                          '${msg.isNotEmpty ? msg : 'No signal'}',
                          textScaleFactor: !isBackgroundBar ? 1 : 1.2,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: !isBackgroundBar
                                        ? Globals.upTrendMsgList.contains(msg)
                                            ? Colors.white
                                            : Colors.black
                                        : Globals.upTrendMsgList.contains(msg)
                                            ? MyColors.upTrendColor
                                            : MyColors.downTrendColor,
                                    shadows: !isBackgroundBar
                                        ? null
                                        : <Shadow>[
                                            Shadow(
                                              offset: Offset(0.5, 0.5),
                                              blurRadius: 0.5,
                                              color: MyColors.richBlack,
                                            )
                                          ],
                                  ),
                        ),
            ),
            Transform.translate(
              offset: Offset(isAlternateDecoration() ? -3 : -13,
                  isAlternateDecoration() ? 6 : 2),
              child: alertStore != null && alertStore.calls.length > 0
                  ? Container(
                      width: 11,
                      height: 11,
                      decoration: new BoxDecoration(
                        color: Globals.upTrendMsgList.contains(msg)
                            ? MyColors.upTrendColor
                            : MyColors.downTrendColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Text(
                        '${alertStore.calls.length}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 8,
                          color: Theme.of(context).colorScheme.primary,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.4, 0.4),
                              blurRadius: 0.3,
                              color: MyColors.richBlack,
                            )
                          ],
                        ),
                      )),
                    )
                  : null,
            )
          ],
        ),
      ],
    );
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

  Widget _priceColumn(BuildContext context, CoinController controller) {
    CoinDataModel coin = controller.coinData.value!;
    num price = (coin.priceData?.usd) ?? Globals.zeroMoney;
    var a = price.toString().split('.');

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
                  text:
                      '${coin.coinMarketData?.currentPrice ?? Globals.zeroMoney}',
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

  Widget _fullPriceProgressIndicator(CoinController controller) {
    final percentage = controller.getPercentageDifference();
    return Container(
      child: FractionallySizedBox(
        alignment: percentage > 0 ? Alignment.topLeft : Alignment.topRight,
        widthFactor:
            (getPercentageChangeProgress(percentage: percentage) / 100).abs(),
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