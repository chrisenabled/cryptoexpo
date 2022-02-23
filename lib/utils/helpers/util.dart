

import 'dart:math';

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_meta_data.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/models/trade_calls_store.dart';
import 'package:cryptoexpo/utils/helpers/local_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<String?> myLoadAsset(String path) async {
  try {
    return await rootBundle.loadString(path);
  } catch(_) {
    return null;
  }
}

int getRandomNum(int min, int max) {
  return min + new Random().nextInt((max + 1) - min);
}

extension myNumExtension on num {
  num toDecimalNumber(int decimal) {
    return num.parse(this.toStringAsFixed(decimal));
  }
}

T? getTypeFromJson<T>(dynamic _json) {
  if(_json is List) {
    print('$_json');
  }
  if(_json is T) return _json;

  return null;
}

num getPercentageDiff({required num initial,
  required num current, int fraction = 2}) {
  if(initial <= 0 || current <= 0) {
    return 0.0;
  }
  num end = current > initial ? current : initial;
  num start = current > initial ? initial : current;
  num percentage = double.parse((((end - start) / start)  * 100)
      .toStringAsFixed(fraction));
  return current >= initial ? percentage : -(percentage);
}

num tradeCallCurrentProfit(TradeCallStore store, CoinController controller) {
  if(store.coinId != controller.coinMeta.id) {
    throw Exception('store coin id must be same as controller id. '
        'store coin id: ${store.coinId}, '
        'controller coin id: ${controller.coinMeta.id}');
  }
  num percentage = 0.0;

  if(store.calls.length > 0) {
    final current = controller.coinData.value?.priceData?.usd?? 0.0;
    final initial = store.calls.first.price?? 0.0;
    percentage = getPercentageDiff(initial: initial, current: current);
  }
  return percentage;
}

num  getPercentageChangeProgress ({required num percentage}) {
  return (percentage % 100).abs() == 0
      ? (percentage.abs() / 100).floor() > 0
      ? 100
      : 0
      : double.parse((percentage.abs() % 100).toStringAsFixed(2));
}

int getRandomNumber(int min, int max, {bool includeMax: false}) {
  final random = new Random();
  final int diff = !includeMax? max - min : (max - min) + 1;
  return min + random.nextInt(diff);
}

void updateTradingCalls (TradeCallStore store,
    List<SignalAlert> alerts)  {

  _updateTradeCall(store, alerts);

  // return compute(_updateTradeCall, signalAlert);
}

void _updateTradeCall(TradeCallStore store,
    List<SignalAlert> alerts) {

  // print('updateTradeCall: for '
  //     '${signalAlert.coinId}:''${call.length}:'
  //     '${signalAlert.alertMsg}:${signalAlert.duration}'
  //     ':${signalAlert.indicatorName}'
  // );

  alerts.forEach((alert) {
    if(store.calls.isEmpty) {
      if(alert.alertCode == 1) {
        store.calls.add(alert);
      }
    } else {
      if(alert.alertCode == 1 && store.calls.last.alertCode == 0) {
        LocalStore.getOrUpdateTradeCallsHistory(
            tradeCallsStore: store);
        store.calls.clear();
      }
      store.calls.add(alert);
    }
  });

  LocalStore.getOrSetTradeCallStore(tradeCallStore: store);
}

List<List<SignalAlert>> getTradeCalls(List<SignalAlert> signalAlerts) {
  List<List<SignalAlert>> tradeCalls = [].cast<List<SignalAlert>>();
  List<SignalAlert> unitTradeCalls = <SignalAlert>[];
  bool hasDetectedUpSignal = false;
  signalAlerts.forEach((signalAlert) {
    if(unitTradeCalls.isNotEmpty) {
      unitTradeCalls.add(signalAlert);
    }

    if(signalAlert.alertCode == 1) {
      if(!hasDetectedUpSignal) {
        unitTradeCalls.add(signalAlert);
        hasDetectedUpSignal = true;
      }
    } else {
      hasDetectedUpSignal = false;
      tradeCalls.add(List.from(unitTradeCalls));
      unitTradeCalls = <SignalAlert>[];
    }
  });
  return tradeCalls;
}

num tradeCallPercentage(List<SignalAlert> signalAlerts) {
  return getPercentageDiff(
      initial: signalAlerts[0].price!,
      current: signalAlerts[signalAlerts.length - 1].price!
  );
}

List<num> percentagePerformanceHistory(
    List<SignalAlert> signalAlerts) {
  final List<List<SignalAlert>> tradeCalls = getTradeCalls(signalAlerts);
  final List<num> tradeCallPercentages = <num>[];
  tradeCalls.forEach((tradeCall) {
    tradeCallPercentages.add(tradeCallPercentage(tradeCall));
  });
  return tradeCallPercentages;
}
