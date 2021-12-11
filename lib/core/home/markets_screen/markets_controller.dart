
import 'package:cryptoexpo/core/home/home_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:get/get.dart';

class MarketsController extends GetxController {

  final HomeController _homeController = HomeController.to;

  Rx<List<CoinMetaData>?> get followedMarkets => _homeController.followedMarkets;

  List<CoinMetaData> get allCoinMetas => _homeController.allCoinMetas;

  @override
  void onInit() {
    super.onInit();
  }

  saveFollowedMarket(CoinMetaData market) {
    _homeController.saveFollowedMarket(market);
  }

  removeFollowedMarket(CoinMetaData market) {
    _homeController.removeFollowedMarket(market);
  }

}