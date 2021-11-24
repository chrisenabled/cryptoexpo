

import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:get/get.dart';

class MarketsController extends GetxController {

  Rx<List<CoinMetaData>?> _followedMarkets = SharedPref.getOrSetMarkets().obs;

  Rx<List<CoinMetaData>?> get followedMarkets => _followedMarkets;

  final List<CoinMetaData> allCoinMetas = Get.find();


  saveFollowedMarket(CoinMetaData market) {

    List<CoinMetaData> markets = [...?_followedMarkets.value];

    CoinMetaData mk = markets.firstWhere(
            (m) => m.symbol == market.symbol, orElse: () => CoinMetaData());

    if(mk.id != null) {
      return;
    }

    List<CoinMetaData> newMarkets = [...?_followedMarkets.value, market];

    Get.put<CoinController>(
        CoinController(coinMeta: market), tag: market.id);

    SharedPref.getOrSetMarkets(markets: newMarkets);

    _followedMarkets.value = List.from(newMarkets);
  }

  removeFollowedMarket(CoinMetaData market) {

    List<CoinMetaData> markets = [...?_followedMarkets.value];

    CoinMetaData mk = markets.firstWhere(
            (m) => m.symbol == market.symbol, orElse: () => CoinMetaData()
    );

    if(mk.symbol != null) {
      markets.removeWhere((m) => m.id == mk.id);
      Get.delete<CoinController>(tag: mk.id);
      SharedPref.getOrSetMarkets(markets: markets);
      _followedMarkets.value = [...markets];
    }

  }

}