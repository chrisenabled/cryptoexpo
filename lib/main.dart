import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data_model.dart' as Coin;
import 'package:cryptoexpo/modules/services/coin_coingecko_service.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:cryptoexpo/widgets/loading.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_themes.dart';
import 'config/languages/language_controller.dart';
import 'config/themes/theme_controller.dart';
import 'config/languages/localization.g.dart';
import 'core/auth/auth_controller.dart';
import 'modules/services/coin_firestore_service.dart';

void main() async {

  // Ensure WidgetsBinding instantiated required to use platform channels
  // (Firebase.initializeApp() needs to call native code)
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();

  // prefetch Svg images to reduce loading lag
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder,
      'assets/images/cx-landing.svg'),null);

  //initialize app-wide services
  Get.put(CoinCoinGeckoService());
  Get.put(CoinFirestoreService());

  // initialize app-wide controllers
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());

  final coinMetaDatas = (await readJsonCoinIds()).sublist(0,30);

  Get.put<List<CoinMetaData>>(coinMetaDatas);

  final List<CoinMetaData>? followedMarkets = SharedPref.getOrSetMarkets();

  if(followedMarkets != null && followedMarkets.length > 0) {
    followedMarkets.forEach((coinMeta) {
      print('i am looping coin metas sublist now @: ${coinMeta.id}');
      Get.put<CoinController>(
          CoinController(coinMeta: coinMeta), tag: coinMeta.id);
    });
  } else {
    List<CoinMetaData> coinMetas = [];
    coinMetaDatas.forEach((coinMeta) {
      if(['zoc','algohalf', 'bchhalf','adahalf'].contains(coinMeta.symbol?.toLowerCase())) {
        print('i am looping coin metas sublist now @: ${coinMeta.id}');
        Get.put<CoinController>(
            CoinController(coinMeta: coinMeta), tag: coinMeta.id);
        coinMetas.add(coinMeta);
      }
    });
    SharedPref.getOrSetMarkets(markets: coinMetas);
  }

  //load CoinDataControllers
  // CoinUrls.forEach((uri) {
  //   Get.put<CoinDataController>(CoinDataController(uri: uri), tag: uri);
  // });
  //call same instance with tags
  //get _ => Get.find<AttachController>(tag: tag);

  // set preferred orientation to portrait mode
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) {
    if(kIsWeb && !kReleaseMode) {
      runApp(DevicePreview(builder: (context) => MyApp()));
    } else {
      runApp(MyApp());
    }
  });

}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // late AppLifecycleState _notification;

  // Since foreground brightness reverted after changing the app lifecycle,
  // we use flutter's WidgetsBindingObserver mixin.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(Get.isDarkMode || Get.isPlatformDarkMode) {
      AppThemes.darkSystemUiOverlayStyle();
    } else {
      AppThemes.lightSystemUiOverlayStyle();

    }
  }


  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) {
        return Loading(
          child: GetMaterialApp(
            translations: Localization(),
            locale: languageController.getLocale, // <- Current locale
            navigatorObservers: [
              // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
            ],
            debugShowCheckedModeBanner: false,
            //defaultTransition: Transition.fade,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: "/",
            getPages: AppRoutes.routes,
          ),
        );
      },
    );
  }

}