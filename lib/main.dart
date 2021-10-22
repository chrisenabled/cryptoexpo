import 'package:cryptoexpo/widgets/loading.dart';
import 'package:firebase_core/firebase_core.dart';
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

void main() async {

  // Ensure WidgetsBinding instantiated required to use platform channels
  // (Firebase.initializeApp() needs to call native code)
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();

  // prefetch Svg images to reduce loading lag
  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder,
      'assets/images/cx-landing.svg'),null);

  // initialize app-wide controllers
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());

  // set preferred orientation to portrait mode
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));

  // if(kReleaseMode) {
  //   runApp(MyApp());
  // } else {
  //   runApp(DevicePreview(builder: (context) => MyApp()));
  // }
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
    // setState(() { _notification = state; });
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