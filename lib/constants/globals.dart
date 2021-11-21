
class Globals {
  static final String defaultLanguage = Lang.english.code;
  static final num zeroMoney = 0.00;
  static  const AlertTypes = ['MacD', 'Trend'];
//List of languages that are supported.  Used in selector.
//Follow this plugin for translating a google sheet to languages
//https://github.com/aloisdeniel/flutter_sheet_localization
//Flutter App translations google sheet
//https://docs.google.com/spreadsheets/d/1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk/edit?usp=sharing
}

enum TradePeriod {
  FiveMin,
  FifteenMin,
  FourHours,
  OneWeek,
}

extension TradePeriodExtension on TradePeriod {
  String get string {
    switch(this) {
      case TradePeriod.FiveMin: return '5m';
      case TradePeriod.FifteenMin: return '15m';
      case TradePeriod.FourHours: return '4h';
      case TradePeriod.OneWeek: return '1w';
    }
  }

  int get number {
    switch(this) {
      case TradePeriod.FiveMin: return 5;
      case TradePeriod.FifteenMin: return 15;
      case TradePeriod.FourHours: return 240;
      case TradePeriod.OneWeek: return 10080;
    }
  }
}

enum Lang {
  english,
  chinese,
  deutsche,
  spanish,
  french,
  hindi,
  japanese,
  portuguese,
  russian
}

extension LangExtension on Lang {

  String get name {
    switch(this) {
      case Lang.chinese: return "中文";
      case Lang.deutsche: return "Deutsche";
      case Lang.english: return "English";
      case Lang.spanish: return "Español";
      case Lang.french: return "Français";
      case Lang.hindi: return "हिन्दी";
      case Lang.japanese: return "日本語";
      case Lang.portuguese: return "Português";
      case Lang.russian: return "русский";
    }
  }

  String get code {
    switch(this) {
      case Lang.chinese: return "zh";
      case Lang.deutsche: return "de";
      case Lang.english: return "en";
      case Lang.spanish: return "es";
      case Lang.french: return "fr";
      case Lang.hindi: return "hi";
      case Lang.japanese: return "ja";
      case Lang.portuguese: return "pt";
      case Lang.russian: return "ru";
    }
  }
}

enum Markets {
  BTC_USDT,
  ETH_USDT,
  BIT_USDT,
  ADA_USDT,
  XRP_USDT,
  DOT_USDT,
}

extension MarketsExt on Markets {
  String get string {
    switch(this) {
      case Markets.BTC_USDT: return "BTC/USDT";
      case Markets.ETH_USDT: return "ETH/USDT";
      case Markets.BIT_USDT: return "BIT/USDT";
      case Markets.ADA_USDT: return "ADA/USDT";
      case Markets.XRP_USDT: return "XRP/USDT";
      case Markets.DOT_USDT: return "DOT/USDT";
    }
  }
}

enum Assets {
  BTC,
  ETH,
  BIT,
  ADA,
  XRP,
  DOT,
}

extension AssetsExt on Assets {
  String get string {
    switch(this) {
      case Assets.BTC: return "BTC/USDT";
      case Assets.ETH: return "ETH/USDT";
      case Assets.BIT: return "BIT/USDT";
      case Assets.ADA: return "ADA/USDT";
      case Assets.XRP: return "XRP/USDT";
      case Assets.DOT: return "DOT/USDT";
    }
  }
}
