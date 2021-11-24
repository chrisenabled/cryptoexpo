

import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/alert_model.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/services/coin_coingecko_service.dart';
import 'package:cryptoexpo/modules/services/coin_firestore_service.dart';
import 'package:get/get.dart';


class CoinController extends GetxController {

  final CoinCoinGeckoService coinGeckoService = CoinCoinGeckoService.to;

  final CoinFirestoreService coinFirestoreService = CoinFirestoreService.to;

  Rxn<CoinDataModel> coinDataStream = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> coinData = Rxn<CoinDataModel>();

  Rxn<SignalAlert> signalAlertStream = Rxn<SignalAlert>();

  final alerts = <Rx<AlertModel>>[];

  num oldPrice = 0.00;




  CoinMetaData coinMeta;

  CoinController({
    required this.coinMeta
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Globals.AlertTypes.forEach((type) {
      alerts.add(AlertModel(type: type, duration: 5).obs,);
      alerts.add(AlertModel(type: type, duration: 15).obs,);
      alerts.add(AlertModel(type: type, duration: 240).obs,);
      alerts.add(AlertModel(type: type, duration: 10080).obs,);
    });
    coinData.value = CoinDataModel(metaData: coinMeta);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    //run every time auth state changes
    ever(coinDataStream, _handleCoinChanged);

    ever(signalAlertStream, _handleSignalAlert);

    _loadFullData();

    coinDataStream.bindStream(coinGeckoService.priceDataChanges(
        coinMeta.priceUri));

    signalAlertStream.bindStream(
        coinFirestoreService.signalStream(coinMeta.symbol!));
  }

  _loadFullData() async {
    CoinDataModel? c = await coinGeckoService.getCoinData(coinMeta);
    if (c != null) {
      coinData.value = coinData.value?.copyWith(other: c);
      print('current price from initial is ${c.coinMarketData?.currentPrice}');
    } else {
      await Future.delayed(Duration(seconds: 10), (){
        _loadFullData();
      });
    }
  }

  _handleCoinChanged(_coinData) {
    if(_coinData != null) {
      final priceData = (_coinData as CoinDataModel).priceData;
      if(coinData.value?.priceData?.usd != priceData?.usd) {
        oldPrice = coinData.value!.priceData?.usd!?? oldPrice;
        coinData.value = coinData.value!.copyWith(priceData: priceData);
        update();
      }
    }
  }

  _addNewAlert(SignalAlert newAlert) {
    final alert = alerts.firstWhere((alert)
    => alert.value.type == newAlert.alertType
        && alert.value.duration == newAlert.duration,
    );
    alert.value = alert.value.copyWith(alerts: [newAlert]);
  }

  _handleSignalAlert(alert) {
    if(alert != null) {
      _addNewAlert(alert);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}