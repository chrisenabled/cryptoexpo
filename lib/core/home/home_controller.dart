
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:cryptoexpo/widgets/lottie_buttom_navigation.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {

  static HomeController to = Get.find();

  RxInt _selectedPos = 0.obs;

  RxInt get selectedPos => _selectedPos;

  String? _selectedDerivative = (Get.find<List<CoinMetaData>>())[0].id ;

  String? get selectedDerivative => _selectedDerivative ;

  List<SignalIndicator>? get indicators => SharedPref.getOrSetSignalIndicator();

  late LottieBottomNavigationController bottomNavigationController;


  final Rx<List<CoinMetaData>?> _followedMarkets =
      SharedPref.getOrSetMarkets().obs;

  Rx<List<CoinMetaData>?> get followedMarkets => _followedMarkets;

  List<CoinMetaData> get allCoinMetas => Get.find();

  @override
  void onInit() {
    super.onInit();

    bottomNavigationController =
        LottieBottomNavigationController(_selectedPos.value);

    bottomNavigationController.addListener(_handleBottomNavSelection);
  }

  void _handleBottomNavSelection() {
    _selectedPos.value = bottomNavigationController.value;
    update();
  }

  saveFollowedMarket(CoinMetaData market) {

    List<CoinMetaData> markets = [...?_followedMarkets.value];

    CoinMetaData mk = markets.firstWhere(
            (m) => m.symbol == market.symbol, orElse: () => CoinMetaData());

    if(mk.id != null) {
      return;
    }

    List<CoinMetaData> newMarkets = [...?_followedMarkets.value, market];

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
      SharedPref.getOrSetMarkets(markets: markets);
      _followedMarkets.value = [...markets];
    }

  }

  void navigateToDerivative(String coinId) {
    _selectedDerivative = coinId;
    bottomNavigationController.value = 2;
  }

}