
class Globals {
  static final String defaultLanguage = Lang.english.code;
//List of languages that are supported.  Used in selector.
//Follow this plugin for translating a google sheet to languages
//https://github.com/aloisdeniel/flutter_sheet_localization
//Flutter App translations google sheet
//https://docs.google.com/spreadsheets/d/1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk/edit?usp=sharing
}

enum Lang {
  chinese,
  deutsche,
  english,
  spanish,
  french,
  hindi,
  japanese,
  portuguese,
  russian
}

extension LangExtention on Lang {

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
