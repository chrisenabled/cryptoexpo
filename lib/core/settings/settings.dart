import 'package:cryptoexpo/modules/models/menu_option_model.dart';
import 'package:cryptoexpo/constants/constants.dart';

class Settings {

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: Lang.chinese.code, value: Lang.chinese.name), //Chinese
    MenuOptionsModel(key: Lang.deutsche.code, value: Lang.deutsche.name), //German
    MenuOptionsModel(key: Lang.english.code, value: Lang.english.name), //English
    MenuOptionsModel(key: Lang.spanish.code, value: Lang.spanish.name), //Spanish
    MenuOptionsModel(key: Lang.french.code, value: Lang.french.name), //French
    MenuOptionsModel(key: Lang.hindi.code, value: Lang.hindi.name), //Hindi
    MenuOptionsModel(key: Lang.japanese.code, value: Lang.japanese.name), //Japanese
    MenuOptionsModel(key: Lang.portuguese.code, value: Lang.portuguese.name), //Portuguese
    MenuOptionsModel(key: Lang.russian.code, value: Lang.russian.name), //Russian
  ];
}