
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class CoinFirestoreService {

  static CoinFirestoreService to = Get.find();

  Stream<SignalAlert> signalStream(String coinId) =>
      Stream.periodic(Duration(seconds: 45))
          .asyncMap((event) => _fakeSignalAlert(coinId))
          .asBroadcastStream(onCancel: (sub) => sub.cancel()) ;

  Future<SignalAlert> _fakeSignalAlert(String coinId) async {
    final alert = Globals.alertList[
      getRandomNumber(0, Globals.alertList.length)
    ];
    final alertType = alert.keys.first;
    final alertMsg = alert.values.first[
      getRandomNumber(0, alert.values.first.length)
    ];
    final duration = Globals.durations[
      getRandomNumber(0, Globals.durations.length)
    ];

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