

import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_alert.dart';
import 'package:cryptoexpo/modules/services/coin_coingecko_service.dart';
import 'package:cryptoexpo/modules/services/coin_firestore_service.dart';
import 'package:get/get.dart';

class CoinController extends GetxController {

  final CoinCoinGeckoService coinGeckoService = CoinCoinGeckoService.to;

  final CoinFirestoreService coinFirestoreService = CoinFirestoreService.to;

  Rxn<CoinDataModel> coinData = Rxn<CoinDataModel>();

  Rxn<SignalAlert> signalAlert = Rxn<SignalAlert>();



  CoinMetaData coinMeta;

  CoinController({
    required this.coinMeta
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    coinData.value = CoinDataModel(metaData: coinMeta);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    //run every time auth state changes
    ever(coinData, handleCoinChanged);

    coinData.bindStream(coinGeckoService.priceDataChanges(
        coinMeta.priceUri, coin: coinData.value));

    signalAlert.bindStream(coinFirestoreService.signalStream(coinMeta.id!));
  }

  handleCoinChanged(_coinData) {
    // if (_coinData != null) {
    //   final coinData = _coinData as CoinDataModel;
    //   print('current price is: ${coinData.tickers!.last.toString()}');
    //   // update();
    // }
  }

  loadCoinData(String? callerId) async {
    coinData.value = await coinGeckoService.getCoinData(coinData.value!.metaData!.coinUri);
    if(callerId != null) update([callerId]);
  }

  @override
  void onClose() {
    super.onClose();
  }
}