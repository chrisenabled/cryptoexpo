

import 'dart:async';

import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/signal_alert_store.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/services/coin_coingecko_service.dart';
import 'package:cryptoexpo/modules/services/coin_firestore_service.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:cryptoexpo/utils/helpers/local_store.dart';
import 'package:get/get.dart';


class CoinController extends GetxController {

  final CoinCoinGeckoService _coinGeckoService = CoinCoinGeckoService.to;

  final CoinFirestoreService _coinFirestoreService = CoinFirestoreService.to;

  Rxn<CoinDataModel> _coinDataStream = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> _coinData = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> get coinData => _coinData;

  Rxn<SignalAlert> _signalAlertStream = Rxn<SignalAlert>();

  final _tradeCallStores = <Rx<SignalAlertStore>>[];

  List<Rx<SignalAlertStore>> get tradeCallStores => _tradeCallStores;

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

    _coinData.value = CoinDataModel(metaData: coinMeta);

    _setUpTradeCallStores();

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

    _setUpAlertStream();
  }


  _setUpAlertStream() {

    StreamSubscription<SignalAlert>? subscription;

    _subscribe(event) {
      _signalAlertStream.value = event;
    }

    _mayBeSubscribe(List<CoinMetaData>? followedCoins) {
      if(followedCoins != null && followedCoins.length > 0) {
        if(followedCoins.contains(coinMeta)) {
          final stream = _coinFirestoreService.signalStream(coinMeta.id!);
          subscription = stream.listen(_subscribe);
        } else {
          subscription?.cancel();
        }
      }
    }

    _mayBeSubscribe(LocalStore.getOrSetMarkets());

    LocalStore.box.listenKey(LocalStore.marketsKey, (value) {
      if(value is List<Map<String, dynamic>>) {

        final List<CoinMetaData> coins =
          value.map((e) => CoinMetaData().fromJson(e)).toList();

        _mayBeSubscribe(coins);

      }
    });
  }

  _setUpTradeCallStores() {
    final indicators = LocalStore.getOrSetSignalIndicator();

    if(indicators != null && indicators.length > 0) {
      indicators.forEach((indicator) {
        indicator.durationsInMin!.forEach((duration) {

          final tradeCall = SignalAlertStore(
              indicatorName: indicator.name!, duration: duration).obs;

          _tradeCallStores.add(tradeCall);

          final key = LocalStore.unitTradeCallPreKey
              + coinMeta.id!
              + indicator.name!
              + '$duration';

          LocalStore.box.listenKey(key, (value) {
            printInfo(info: 'value updated in storage: $key');
            if(value is List<Map<String, dynamic>>) {
               final signals = value.map((e) => SignalAlert().fromJson(e))
                      .cast<SignalAlert>()
                      .toList();

               tradeCall.value =
                   tradeCall.value.copyWith(alerts: signals);
            }
          });
        });
      });
    } else {
      Globals.AlertTypes.forEach((type) {
        _tradeCallStores.add(SignalAlertStore(indicatorName: type, duration: 5).obs,);
        _tradeCallStores.add(SignalAlertStore(indicatorName: type, duration: 15).obs,);
        _tradeCallStores.add(SignalAlertStore(indicatorName: type, duration: 240).obs,);
        _tradeCallStores.add(SignalAlertStore(indicatorName: type, duration: 10080).obs,);
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

  _handleSignalAlert(alert) {
    if(alert != null) {
      updateTradingCalls(alert);
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