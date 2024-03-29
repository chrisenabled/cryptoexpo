


import 'dart:ui';

import 'package:cryptoexpo/core/home/trending_coins_widget/trending_coins_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'config/languages/language_controller.dart';
import 'config/themes/app_themes.dart';
import 'config/themes/theme_controller.dart';
import 'constants/test_data.dart';
import 'core/auth/auth_controller.dart';
import 'modules/controllers/controllers.dart';
import 'modules/models/coin_data/coin_data.dart';
import 'modules/services/services.dart';
import 'utils/helpers/local_store.dart';

class MainController extends FullLifeCycleController {

  static MainController to = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _initAppWideInstances();
    _preCacheImages();
  }

  // Since foreground brightness reverted after changing the app lifecycle,
  // we use flutter's WidgetsBindingObserver mixin.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    useAppropriateThemeMode();
  }

  void _initAppWideInstances() {
    _initAppWideServices();
    _setUpSignalIndicators();
    _initAppWideControllers();
    _initCoinMetaDatas();
  }

  void _initAppWideServices() {
    Get.put(CoinGeckoService());
    Get.put(CoinFirestoreService());
  }

  void _initAppWideControllers() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
    Get.put<LanguageController>(LanguageController(), permanent: true);
  }

  Future<void> _setUpSignalIndicators() async {
   CoinGeckoService.to.readJsonIndicators()
       .then((value) =>
       LocalStore.getOrSetSignalIndicator(indicators: value));
  }

  Future<void> _initCoinMetaDatas()  async {

    final coinMetaDatas = (await readJsonCoinIds());

    final majorCoins = coinMetaDatas.where(
            (coin) => ['btc','eth','bnb']
                .contains(coin.symbol!.toLowerCase())).toList();

    Get.put<List<CoinMetaData>>(majorCoins, permanent: true);

    majorCoins.forEach((coinMeta) {
      Get.put<CoinController>(
          CoinController(coinMeta: coinMeta),
          tag: coinMeta.id,
          permanent: true
      );
    });

    final List<CoinMetaData>? followedMarkets = LocalStore.getOrSetMarkets();

    if(followedMarkets == null || followedMarkets.length == 0) {
      LocalStore.getOrSetMarkets(markets: majorCoins);
    }
  }

  Future<void> _preCacheImages() async {
    // prefetch Svg images to reduce loading lag
    await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
        'assets/images/cx-landing.svg'),null);
  }

  void useAppropriateThemeMode() {
    if(Get.isDarkMode || Get.isPlatformDarkMode) {
      AppThemes.darkSystemUiOverlayStyle();
    } else {
      AppThemes.lightSystemUiOverlayStyle();
    }
  }

}