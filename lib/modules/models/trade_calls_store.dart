

import 'package:cryptoexpo/modules/interfaces/json_serialized.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/utils/helpers/local_store.dart';
import 'package:cryptoexpo/utils/helpers/util.dart';
import 'package:collection/collection.dart';

class TradeCallStore implements JsonSerialized {
  final String? indicatorName;
  final String? coinId;
  final num? duration;
  List<SignalAlert> calls;

  String get halfKey =>'$coinId$indicatorName$duration';

  String get historyKey => '${LocalStore.tradeCallsHistoryPreKey}$halfKey';

  String get storeKey => '${LocalStore.tradeCallPreKey}$halfKey';

  num get percentageProfit {
    if(calls.length > 0) {
      final SignalAlert? sellCall =
      calls.firstWhereOrNull((element) => element.alertCode == 0);

      if(sellCall != null) {
        return getPercentageDiff(
            initial: calls.first.price!,
            current: sellCall.price!,fraction: 3);
      }
    }
    return 0.0;
  }

  TradeCallStore({
    this.coinId,
    this.indicatorName,
    this.duration,
    calls,
  }) : calls = calls?? <SignalAlert>[];

  TradeCallStore copyWith({
     List<SignalAlert>? calls,
     num? percentageGain
}) {
    return TradeCallStore(
        coinId: this.coinId,
        indicatorName: this.indicatorName,
        duration: this.duration,
        calls: calls?? this.calls,
    );

  }

  @override
  TradeCallStore fromJson(Map map) {
    final json = map as Map<String, dynamic>;

    return TradeCallStore(
      coinId: json['coinId'],
      indicatorName: json['indicatorName'],
      duration: json['duration'],
      calls: SignalAlert()
          .listFromJson(json['signalAlerts'])
          ?.cast<SignalAlert>(),
    );
  }

  @override
  List<TradeCallStore>? listFromJson(List<dynamic>? json) {
    if(json == null || json.length == 0) return null;

    final list = json.cast<Map<String, dynamic>>();
    return list.map((j) => TradeCallStore().fromJson(j)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'coinId': coinId,
      'indicatorName': indicatorName,
      'duration': duration,
      'calls': calls.length > 0
          ? calls.map((e) => e.toJson()).toList()
          : <Map<String, dynamic>>[]
    };
  }
}