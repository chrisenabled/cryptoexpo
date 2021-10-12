import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'common/widgets/loading.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_themes.dart';
import 'config/languages/language_controller.dart';
import 'config/themes/theme_controller.dart';
import 'config/languages/localization.g.dart';
import 'core/auth/auth_controller.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await GetStorage.init();

  await precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder,
      'assets/images/cx-landing.svg'),null);

  Get.put<AuthController>(AuthController());
  //
  Get.put<ThemeController>(ThemeController());

  Get.put<LanguageController>(LanguageController());

  runApp(MyApp());
  // if(kReleaseMode) {
  //   runApp(MyApp());
  // } else {
  //   runApp(DevicePreview(builder: (context) => MyApp()));
  // }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) => Loading(
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
      ),
    );
  }
}