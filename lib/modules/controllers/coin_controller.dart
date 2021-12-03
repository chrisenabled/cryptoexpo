

import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/signal_alert_store.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/services/coin_coingecko_service.dart';
import 'package:cryptoexpo/modules/services/coin_firestore_service.dart';
import 'package:cryptoexpo/utils/helpers/converters.dart';
import 'package:get/get.dart';


class CoinController extends GetxController {

  final CoinCoinGeckoService _coinGeckoService = CoinCoinGeckoService.to;

  final CoinFirestoreService _coinFirestoreService = CoinFirestoreService.to;

  Rxn<CoinDataModel> _coinDataStream = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> _coinData = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> get coinData => _coinData;

  Rxn<SignalAlert> _signalAlertStream = Rxn<SignalAlert>();

  final _alerts = <Rx<SignalAlertStore>>[];

  List<Rx<SignalAlertStore>> get alerts => _alerts;

  num _oldPrice = 0.00;

  num get oldPrice => _oldPrice;

  num _priceDifference = 0.0;

  num get priceDifference => _priceDifference;

  CoinMetaData coinMeta;

  CoinController({
    required this.coinMeta
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Globals.AlertTypes.forEach((type) {
      _alerts.add(SignalAlertStore(type: type, duration: 5).obs,);
      _alerts.add(SignalAlertStore(type: type, duration: 15).obs,);
      _alerts.add(SignalAlertStore(type: type, duration: 240).obs,);
      _alerts.add(SignalAlertStore(type: type, duration: 10080).obs,);
    });
    _coinData.value = CoinDataModel(metaData: coinMeta);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    //run every time auth state changes
    ever(_coinDataStream, _handleCoinChanged);

    ever(_signalAlertStream, _handleSignalAlert);

    _loadFullData();

    _coinDataStream.bindStream(_coinGeckoService.priceDataChanges(
        coinMeta.priceUri));

    _signalAlertStream.bindStream(
        _coinFirestoreService.signalStream(coinMeta.symbol!));
  }

  _loadFullData() async {
    CoinDataModel? c = await _coinGeckoService.getCoinData(coinMeta);
    if (c != null) {
      final priceData = CoinPriceData(
        coinId: c.id,
        usd: c.coinMarketData?.currentPrice,
        usdMarketCap: c.coinMarketData?.marketCap,
        usd24hChange: c.coinMarketData?.priceChange24h,
        usd24hVol: c.coinMarketData?.totalVolume
      );
      _coinData.value = _coinData.value?.copyWith(
          priceData: priceData,
          other: c
      );
      printInfo(info: 'current price from initial is'
          ' ${c.coinMarketData?.currentPrice}');
      printInfo(info: 'sparkLine is: '
          '${c.coinMarketData!.sparkLineIn7d?.length} ');
      update();
    } else {
      await Future.delayed(Duration(seconds: 10), (){
        _loadFullData();
      });
    }
  }

  _handleCoinChanged(_coin) {
    if(_coin != null) {
      final priceData = (_coin as CoinDataModel).priceData;
      if(_coinData.value?.priceData?.usd != priceData?.usd) {
        _oldPrice = _coinData.value!.priceData?.usd!?? _oldPrice;
        _coinData.value = _coinData.value!.copyWith(priceData: priceData);
        _priceDifference = (priceData!.usd! - _oldPrice);
        update();
      }
    }
  }

  _addNewAlert(SignalAlert newAlert) {
    final alert = _alerts.firstWhere((alert)
    => alert.value.type == newAlert.signalType
        && alert.value.duration == newAlert.duration,
    );
    alert.value = alert.value.copyWith(alerts: [newAlert]);
  }

  _handleSignalAlert(alert) {
    if(alert != null) {
      _addNewAlert(alert);
    }
  }

  // useful calculations
  num getPercentageDifference() {
    final marketData = _coinData.value?.coinMarketData;
    final priceData = _coinData.value?.priceData;
    return getPercentageDiff(
        initial: marketData?.currentPrice ?? 0.00,
        current: priceData?.usd ?? 0.00);
  }

  num getPercentageX() {
    return getPercentageDifference() / 100;
  }

  num getPercentageProgress() {
    return getPercentageChangeProgress(
        percentage: getPercentageDifference()
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}