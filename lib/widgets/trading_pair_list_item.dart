import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/config/themes/theme_controller.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/alert_model.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/utils/helpers/converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TradingPairListItem extends StatelessWidget {
  final String alertType;
  final bool isBackgroundBar;
  final String coinId;
  final num alertDuration;

  const TradingPairListItem({
    Key? key,
    required this.alertType,
    this.isBackgroundBar = true,
    required this.coinId,
    this.alertDuration = 5,
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinController>(
      // id: Key(indicatorTypeTag),
      tag: coinId,
      builder: (controller) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Stack(
              children: [
                if (isBackgroundBar)
                  Positioned.fill(
                    child: _fullPriceProgressIndicator(controller),
                  ),
                Container(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  padding: const EdgeInsets.only(
                      left: 4, top: 2, bottom: 2, right: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _pairInfoColumn(context, controller),
                          _priceColumn(context, controller),
                          Obx(() {
                            final alert =
                            controller.alerts.firstWhere(
                                    (alert) => (alert.value.duration - alertDuration == 0
                                    && alert.value.type == alertType),
                                orElse: () =>
                                    AlertModel(type: alertType,
                                        duration: alertDuration).obs
                            );
                            return _signalContainer(context, alert.value);
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _xAmount(context, controller),
                          _miniPriceProgressIndicator(context, controller),
                          _percentageDiff(context, controller)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  num _getPercentageDiff(CoinController controller) {
    final marketData = controller.coinData.value?.coinMarketData;
    final priceData = controller.coinData.value?.priceData;
    return getPercentageDiff(
        initial: marketData?.currentPrice ?? 0.00,
        current: priceData?.usd ?? 0.00);
  }

  Expanded _percentageDiff(BuildContext context, CoinController controller) {
    final percentage = _getPercentageDiff(controller);
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

  Expanded _miniPriceProgressIndicator(
      BuildContext context, CoinController controller) {
    final percentage = _getPercentageDiff(controller);
    final _getPercentageProgress =
        getPercentageChangeProgress(percentage: percentage);
    final widthFactor = _getPercentageProgress / 100;

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

  Expanded _xAmount(BuildContext context, CoinController controller) {
    final percentage = _getPercentageDiff(controller);
    final percentageX = (percentage/100);
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

  Widget _signalContainer(
      BuildContext context,
      AlertModel alert
      ) {

    String? msg = '';

    if(alert.signalAlerts != null) {
      if (alert.signalAlerts!.length > 0) {
        final signalAlerts = alert.signalAlerts;
        msg = signalAlerts![signalAlerts.length - 1].alertMsg;
      }
    }
    printInfo(info: 'the alert msg received by $coinId is  $msg');
    bool isAlternateDecoration() {
      return isBackgroundBar || msg == 'bull' || msg == 'bear';
    }

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: isAlternateDecoration()
                ? null
                : msg.isEmpty
                    ? Theme.of(context).colorScheme.surface
                    : msg == 'buy'
                        ? MyColors.upTrendColor
                        : MyColors.downTrendColor,
          ),
          child: msg.isEmpty
              ? Text(Globals.emptyText)
              : isWidget(msg)
                  ? Lottie.asset(
                      'assets/lottie/${msg}_run.json',
                      height: 36,
                    )
                  : Text(
                      '${msg.isNotEmpty ? msg : 'No signal'}',
                      textScaleFactor: !isBackgroundBar ? 1 : 1.2,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: !isBackgroundBar
                                ? msg == 'buy'
                                    ? Colors.white
                                    : Colors.black
                                : msg == 'buy'
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
          child: Container(
            width: 11,
            height: 11,
            decoration: new BoxDecoration(
              color: msg == 'buy' || msg == 'bull'
                  ? MyColors.upTrendColor
                  : MyColors.downTrendColor,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
              '${10}',
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
          ),
        )
      ],
    );
  }

  Column _pairInfoColumn(BuildContext context, CoinController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.coinMeta.symbol?.toUpperCase() ?? 'Cant get Coin Symbol',
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
          'Inverse Perpetual',
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }

  Column _priceColumn(BuildContext context, CoinController controller) {
    CoinDataModel coin = controller.coinData.value!;
    num price = (coin.priceData?.usd) ?? Globals.zeroMoney;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$price',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(
              letterSpacing: 0.5,
            color: price - controller.oldPrice == 0
                ? Theme.of(context).colorScheme.onPrimary
                : price - controller.oldPrice > 0
                ? MyColors.upTrendColor
                : MyColors.downTrendColor
          ),
        ),
        RichText(
          text: TextSpan(
              text: '${coin.coinMarketData?.currentPrice ?? Globals.zeroMoney}',
              style:
                  Theme.of(context).textTheme.caption!.copyWith(fontSize: 9.5),
              children: [
                TextSpan(
                  text: ' USD',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 6),
                )
              ]),
        )
      ],
    );
  }

  Container _fullPriceProgressIndicator(CoinController controller) {
    final percentage = _getPercentageDiff(controller);
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
