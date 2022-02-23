

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/trade_calls_store.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/services/coin_coingecko_service.dart';
import 'package:cryptoexpo/modules/services/coin_firestore_service.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:cryptoexpo/utils/helpers/local_store.dart';
import 'package:get/get.dart';


class CoinController extends GetxController {

  final CoinGeckoService _coinGeckoService = CoinGeckoService.to;

  final CoinFirestoreService _coinFirestoreService = CoinFirestoreService.to;

  Rxn<CoinDataModel> _coinDataStream = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> _coinData = Rxn<CoinDataModel>();

  Rxn<CoinDataModel> get coinData => _coinData;

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
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    //run every time auth state changes
    ever(_coinDataStream, _handleCoinChanged);

    _loadFullData();

    _coinDataStream.bindStream(_coinGeckoService.priceDataChanges(
        coinMeta.priceUri));

    _setUpAlertStream();
  }

  _setUpAlertStream() {

    Map<String,
        StreamSubscription<List<SignalAlert>?>> subscriptions = {};

    _subscribe(List<SignalAlert>? alerts) {
      if(alerts != null && alerts.length > 0) {
        printInfo(info: 'alerts received: ${alerts.length}');
        _handleSignalAlert(alerts);
      }
    }

    _mayBeSubscribeToCoinsUpdates(List<CoinMetaData>? followedCoins) {
      if(followedCoins != null && followedCoins.length > 0) {
        if(followedCoins.contains(coinMeta)) {

          LocalStore.getOrSetSignalIndicator()!.forEach((indicator) {

            indicator.durationsInMin!.forEach((duration) {

              final docPath = '${coinMeta.symbol}'.toLowerCase();

              final collectionPath = '${coinMeta.symbol}${indicator.name}'
                  '$duration'.toLowerCase().replaceAll(' ', '');

             _coinFirestoreService
                  .fetchSignalAlerts<SignalAlert>(
                 docPath: docPath,
                 collectionPath: collectionPath,
                 instance: SignalAlert())
                 .then((value) => _subscribe(value));

              // final stream = _coinFirestoreService
              //     .streamSignalAlerts<SignalAlert>(
              //     docPath: docPath, collectionPath: collectionPath,
              //     instance: SignalAlert()
              // );
              //
              // subscriptions[docPath + collectionPath] =
              //     stream.listen(_subscribe);
            });

          });

        } else {
          if(subscriptions.length > 0) {
            subscriptions.forEach((key, sub) {
              sub.cancel();
            });
          }
        }
      }
    }

    _mayBeSubscribeToCoinsUpdates(LocalStore.getOrSetMarkets());

    LocalStore.box.listenKey(LocalStore.marketsKey, (value) {
      if(value is List<Map<String, dynamic>>) {

        final List<CoinMetaData> coins =
          value.map((e) => CoinMetaData().fromJson(e)).toList();

        _mayBeSubscribeToCoinsUpdates(coins);

      }
    });
  }

  Future<void> tradeCallStoreUpdate(String storeKey,
      void Function(TradeCallStore) callback) async {
     final store = LocalStore.getOrSetTradeCallStore(key: storeKey);
     if(store != null) callback(store);

     LocalStore.box.listenKey(storeKey, (value) {
       if(value is TradeCallStore) {
         callback(value);
       }
     });
  }

  Future<void> _loadFullData() async {
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

  Future<void> _handleSignalAlert(List<SignalAlert> alerts) async {

    printInfo(info: 'firestore alerts returned are: '
        '${alerts.length} in number');

    final arbitraryAlert = alerts[0];

      final key = LocalStore.tradeCallPreKey
          + arbitraryAlert.coinId!
          + arbitraryAlert.indicatorName!
          + '${arbitraryAlert.duration}';

      TradeCallStore? store = LocalStore.getOrSetTradeCallStore(key: key);

      final newAlerts = alerts.map((alert) => alert.copyWith(price: alert.price
          ?? coinData.value?.priceData?.usd)).toList();

      if (store == null) {
        store = TradeCallStore(
          coinId: arbitraryAlert.coinId,
          duration: arbitraryAlert.duration,
          indicatorName: arbitraryAlert.indicatorName
        );
      }

      updateTradingCalls(store, newAlerts);
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

  Future<void> historyUpdate(String historyKey,
      void Function(num) callback) async {

    final stores = LocalStore.getOrUpdateTradeCallsHistory(
        historyKey: historyKey);

    var percentage = 0.0;

    if(stores.length > 0) {
      stores.forEach((element) => percentage += element.percentageProfit);
      percentage /= stores.length;
    }

    callback(num.parse(percentage.toStringAsFixed(3)));

    LocalStore.box.listenKey(historyKey, (value) {
      if(value is List<Map<String, dynamic>>) {
        percentage = 0.0;

        final stores = value.map((e) => TradeCallStore().fromJson(e)).toList();

        stores.forEach(
                (element) {
                  printInfo(info: '${element.storeKey} '
                      'profit : ${element.percentageProfit}');
                  percentage += element.percentageProfit;
                }
        );

        printInfo(info: 'aggregate for: $historyKey: $percentage.'
            ' No. of store: ${stores.length}');

        percentage /= stores.length;

        callback(num.parse(percentage.toStringAsFixed(3)));
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}