
import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:get/get.dart';

List<Map<String, List<String>>> alertList = [
  {'MacD': ['buy', 'sell']},
  {'Trend': ['bull', 'bear']},
];

List<num> durations = [5, 15, 240, 10080];

class CoinFirestoreService {

  static CoinFirestoreService to = Get.find();

  Stream<SignalAlert> signalStream(String coinId) =>
      Stream.periodic(Duration(seconds: 10))
          .asyncMap((event) => _fakeSignalAlert(coinId))
          .asBroadcastStream(onCancel: (sub) => sub.cancel()) ;

  Future<SignalAlert> _fakeSignalAlert(String coinId) async {
    // final coinMetaList = (await readJsonCoinIds()).sublist(0, 30);
    // final coinMeta = coinMetaList[getRandomNumber(0, 29)] as CoinMetaData;
    final alert = alertList[getRandomNumber(0, alertList.length)];
    final alertType = alert.keys.first;
    final alertMsg = alert.values.first[
      getRandomNumber(0, alert.values.first.length)
    ];
    final duration = durations[getRandomNumber(0, durations.length)];

    final signal =  SignalAlert(
      coinId: coinId,
      alertType: alertType,
      alertMsg: alertMsg,
      duration: duration,
    );

    print(signal.toString());

    return signal;

  }
}