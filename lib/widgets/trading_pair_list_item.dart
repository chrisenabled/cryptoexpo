import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/config/themes/theme_controller.dart';
import 'package:cryptoexpo/modules/models/trading_pair_list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TradingPairListItem extends StatelessWidget {
  final TradingPairListItemModel model;
  final bool isBackgroundBar;

  const TradingPairListItem(
      {Key? key, required this.model, this.isBackgroundBar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Stack(
          children: [
            if (isBackgroundBar)
              Positioned.fill(
                child: _fullPriceProgressIndicator(),
              ),
            Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              padding:
                  const EdgeInsets.only(left: 4, top: 2, bottom: 2, right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _pairInfoColumn(context),
                      _priceColumn(context),
                      _signalContainer(context)
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _xAmount(context),
                      _miniPriceProgressIndicator(),
                      _percentageChange(context)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Expanded _percentageChange(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: Text(
            model.getPercentage() > 0
                ? '+${model.getPercentage()}%'
                : '${model.getPercentage()}%',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: model.getPercentage() > 0
                      ? Colors.green
                      : Colors.redAccent,
                  letterSpacing: 1,
                  shadows: !isBackgroundBar
                      ? null
                      : <Shadow>[
                          ThemeController.to.isDarkModeOn
                              ? Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 1.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              : Shadow(
                                  offset: Offset(0.1, 0.1),
                                  blurRadius: 0.3,
                                  color: Color.fromRGBO(252, 252, 252, 0.5),
                                ),
                        ],
                ),
          ),
        ));
  }

  Expanded _miniPriceProgressIndicator() {
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
                  alignment: model.getPercentage() > 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  widthFactor: (model.getPercentageChangeProgress / 100).abs(),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: model.getPercentage() > 0
                          ? Colors.green
                          : Colors.redAccent,
                    ),
                  ),
                ),
              ));
  }

  Expanded _xAmount(BuildContext context) {
    return Expanded(
        flex: 2,
        child: model.percentageChange.abs() < 1
            ? Text(
                '. . .',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.caption,
              )
            : Text(
                '${model.percentageChange}x',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold,
                      // color: MyColors.purpleMunsell
                    ),
              ));
  }

  Widget _signalContainer(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: isBackgroundBar
                ? null
                : model.signal == 'Buy'
                    ? Colors.green
                    : Colors.redAccent,
          ),
          child: Text(
            model.signal,
            textScaleFactor: !isBackgroundBar ? 1 : 1.2,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: !isBackgroundBar
                  ? model.signal == 'Buy'
                  ? Colors.white
                  : Colors.black
                  : model.signal == 'Buy'
                  ? Colors.green
                  : Colors.redAccent,
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
          offset: Offset(isBackgroundBar? -3 :-13, isBackgroundBar? 6 : 2),
          child: Container(
            width: 11,
            height: 11,
            decoration: new BoxDecoration(
              color: model.signal == 'Buy'
                  ? Colors.green
                  : Colors.redAccent,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
                  '${model.signalFrequency}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 8,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.2, 0.2),
                        blurRadius: 0.2,
                        color: MyColors.richBlack,
                      )
                    ],
                  ),
                )
            ),
          ),
        )
      ],
    );
  }

  Column _pairInfoColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.pair,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(
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

  Column _priceColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${model.currentPrice}',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith( letterSpacing: 1),
        ),
        RichText(
          text: TextSpan(
              text: '${model.startPrice}',
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

  Container _fullPriceProgressIndicator() {
    return Container(
      child: FractionallySizedBox(
        alignment:
            model.getPercentage() > 0 ? Alignment.topLeft : Alignment.topRight,
        widthFactor: (model.getPercentageChangeProgress / 100).abs(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: model.getPercentage() > 0 ||
                        (model.getPercentage()).abs() == 100.00
                    ? Radius.circular(3)
                    : Radius.circular(0),
                topRight: model.getPercentage() < 0 ||
                        (model.getPercentage()).abs() == 100.00
                    ? Radius.circular(3)
                    : Radius.circular(0),
                bottomLeft: model.getPercentage() > 0 ||
                        (model.getPercentage()).abs() == 100.00
                    ? Radius.circular(3)
                    : Radius.circular(0),
                bottomRight: model.getPercentage() < 0 ||
                        (model.getPercentage()).abs() == 100.00
                    ? Radius.circular(3)
                    : Radius.circular(0)),
            color: model.getPercentage() > 0 ? Colors.green : Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
