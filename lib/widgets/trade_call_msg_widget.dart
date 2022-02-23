

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/trade_calls_store.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TradeCallSignalMsgWidget extends StatelessWidget {

  TradeCallSignalMsgWidget({
    this.isAlternateDecoration = false,
    this.message,
    this.counter = 0,

  });

  final bool isAlternateDecoration;
  final String? message;
  final int counter;

  bool showIconForSignalMsg(String? message) {
    if (message == null) return false;
    return [
      'bear','bull','uptrend','downtrend'].contains(message.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    bool isAltDecoration() {
      return isAlternateDecoration || showIconForSignalMsg(message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if(counter != 0)
          Transform.translate(
              offset: Offset(0, isAltDecoration()?  -15 : -20),
              child: Container(
                width: 11,
                height: 11,
                decoration: new BoxDecoration(
                  color: Globals.greenList.contains(message)
                      ? MyColors.upTrendColor
                      : MyColors.downTrendColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text(
                      '$counter',
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
          ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: isAltDecoration()? 0 : 10,
              vertical: isAltDecoration()? 2 : 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: isAltDecoration()
                ? null
                : message!.isEmpty
                ? Theme.of(context).colorScheme.surface
                : Globals.greenList.contains(message)
                ? MyColors.upTrendColor
                : MyColors.downTrendColor,
          ),
          child: message!.isEmpty
              ? Text(Globals.emptyText)
              : showIconForSignalMsg(message)
              ? Lottie.asset(
            'assets/lottie/$message.json',
            height: 36,
          )
              : AutoSizeText(
            '${message?? 'No signal'}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            textScaleFactor: !isAltDecoration() ? 1 : 1.2,
            style:
            Theme.of(context).textTheme.bodyText2!.copyWith(
              color: !isAlternateDecoration
                  ? Globals.greenList.contains(message)
                  ? Colors.white
                  : Colors.black
                  : Globals.greenList.contains(message)
                  ? MyColors.upTrendColor
                  : MyColors.downTrendColor,
              shadows: !isAltDecoration()
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
      ],
    );
  }

}