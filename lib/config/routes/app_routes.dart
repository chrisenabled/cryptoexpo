import 'package:cryptoexpo/config/languages/select_language_ui.dart';
import 'package:cryptoexpo/core/auth/reset_password_ui.dart';
import 'package:cryptoexpo/core/auth/sign_in_ui.dart';
import 'package:cryptoexpo/core/auth/sign_up_ui.dart';
import 'package:cryptoexpo/core/auth/update_profile_ui.dart';
import 'package:cryptoexpo/core/home/home_ui.dart';
import 'package:cryptoexpo/core/onboarding/landing_ui.dart';
import 'package:cryptoexpo/core/onboarding/terms_of_use_ui.dart';
import 'package:cryptoexpo/core/settings/settings_ui.dart';
import 'package:cryptoexpo/core/splash_ui.dart';
import 'package:get/get.dart';


class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => Landing()),
    GetPage(name: '/signin', page: () => SignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),

    GetPage(name: '/select-language', page: () => SelectLanguage()),
  ];
}
