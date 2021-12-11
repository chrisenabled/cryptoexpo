

import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/signal_alert_store.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/services/coin_coingecko_service.dart';
import 'package:cryptoexpo/modules/services/coin_firestore_service.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:get/get.dart';


class CoinController extends GetxController {

  final CoinCoinGeckoService _coinGeckoService = CoinCoinGeckoService.to;

  final CoinFirestoreService _coinFirestoreService = CoinFirestoreService.to;

  Rxn<CoinDataModel> _coinDataStream = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> _coinData = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> get coinData => _coinData;

  Rxn<SignalAlert> _signalAlertStream = Rxn<SignalAlert>();

  final _alertStores = <Rx<SignalAlertStore>>[];

  List<Rx<SignalAlertStore>> get alertStores => _alertStores;

  num _oldPrice = 0.00;

  num get oldPrice => _oldPrice;

  num _priceDifference = 0.0;

  num get priceDifference => _priceDifference;

  final CoinMetaData coinMeta;

  CoinController({
    required this.coinMeta
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _setUpSignalAlertStores();

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
        _coinFirestoreService.signalStream(coinMeta.id!));
  }

  _setUpSignalAlertStores() {
    final indicators = SharedPref.getOrSetSignalIndicator();

    if(indicators != null && indicators.length > 0) {
      indicators.forEach((indicator) {
        indicator.durationsInMin!.forEach((duration) {
          _alertStores.add(SignalAlertStore(
              indicatorName: indicator.name!, duration: duration).obs,);
        });
      });
    } else {
      Globals.AlertTypes.forEach((type) {
        _alertStores.add(SignalAlertStore(indicatorName: type, duration: 5).obs,);
        _alertStores.add(SignalAlertStore(indicatorName: type, duration: 15).obs,);
        _alertStores.add(SignalAlertStore(indicatorName: type, duration: 240).obs,);
        _alertStores.add(SignalAlertStore(indicatorName: type, duration: 10080).obs,);
      });

    }
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

      update();
    } else {
      await Future.delayed(Duration(seconds: 10), () {
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

  _addNewAlert(SignalAlert _newAlert) {
    final newAlert = _newAlert
        .copyWith(price: coinData.value?.priceData?.usd);

    final Rx<SignalAlertStore>? alertStore = _alertStores.firstWhereOrNull((store)
    => store.value.indicatorName == newAlert.indicatorName
        && store.value.duration == newAlert.duration,
    );

    if(alertStore != null) {
      alertStore.value = alertStore.value.copyWith(alerts: [newAlert]);
    }
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