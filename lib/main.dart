import 'package:cryptoexpo/main_controller.dart';
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

void main() async {

  // Ensure WidgetsBinding instantiated required to use platform channels
  // (Firebase.initializeApp() needs to call native code)
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await GetStorage.init();

  Get.put(MainController());

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

  MainController mainController = MainController.to;

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