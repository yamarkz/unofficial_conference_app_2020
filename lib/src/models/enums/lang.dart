enum LangType {
  ja,
  en,
  mix,
}

class Lang {
  final String rawValue;
  final LangType type;
  Lang._(this.rawValue, this.type);

  static Lang ja = Lang._('JAPANESE', LangType.ja);

  static Lang en = Lang._('ENGLISH', LangType.en);

  static Lang mix = Lang._('MIXED', LangType.mix);

  static List<Lang> get items => [
        ja,
        en,
        mix,
      ];

  factory Lang.fromJson(Map<dynamic, dynamic> json) {
    String value;
    if (json['name']['ja'] == 'English') value = 'ENGLISH';
    if (json['name']['ja'] == '日本語') value = 'JAPANESE';
    if (json['name']['ja'] == '日英混在') value = 'MIXED';
    return items.firstWhere((item) => item.rawValue == value,
        orElse: () => null);
  }
}

enum SessionLangType {
  ja,
  en,
  tbd,
}

class SessionLang {
  final String rawValue;
  final SessionLangType type;
  SessionLang._(this.rawValue, this.type);

  static SessionLang ja = SessionLang._('日本語', SessionLangType.ja);

  static SessionLang en = SessionLang._('English', SessionLangType.en);

  static SessionLang tbd = SessionLang._('未定', SessionLangType.tbd);

  static List<SessionLang> get items => [
        ja,
        en,
        tbd,
      ];

  factory SessionLang.fromString(String string) {
    String value;
    if (string == 'ENGLISH') value = 'English';
    if (string == 'JAPANESE') value = '日本語';
    if (string == 'TBD') value = '未定';
    return items.firstWhere((item) => item.rawValue == value,
        orElse: () => null);
  }
}
