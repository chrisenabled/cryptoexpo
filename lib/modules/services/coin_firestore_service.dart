
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:cryptoexpo/utils/helpers/local_store.dart';
import 'package:get/get.dart';

class CoinFirestoreService {

  static CoinFirestoreService to = Get.find();

  List<SignalIndicator>? indicators;

  Stream<SignalAlert> signalStream(String coinId) =>
      Stream.periodic(Duration(seconds: 45))
          .asyncMap((event) => _fakeSignalAlert(coinId))
          .asBroadcastStream(onCancel: (sub) => sub.cancel()) ;

  Future<SignalAlert> _fakeSignalAlert(String coinId) async {
    if(indicators == null) {
      indicators = LocalStore.getOrSetSignalIndicator()!;
    }

    final indicator = indicators![getRandomNumber(0, indicators!.length)];

    final indicatorName = indicator.name!;

    final alertMsg = indicator.messages![
      getRandomNumber(0, indicator.messages!.length)];

    final alertCode = indicator.messages!.indexOf(alertMsg);

    final duration = indicator.durationsInMin![
      getRandomNumber(0, indicator.durationsInMin!.length)];

    final signal =  SignalAlert(
      coinId: coinId,
      indicatorName: indicatorName,
      alertMsg: alertMsg,
      alertCode: alertCode,
      duration: duration,
      volume: null,
      price: null,
      time: DateTime.now()
    );

    // printInfo(info: signal.toString());

    return signal;

  }
}