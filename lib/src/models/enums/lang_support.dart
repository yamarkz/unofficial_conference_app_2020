enum LangSupportType {
  interpretation,
}

class LangSupport {
  final String rawValue;
  final LangSupportType type;
  LangSupport._(this.rawValue, this.type);

  static LangSupport ja = LangSupport._('同時通訳', LangSupportType.interpretation);

  static List<LangSupport> get items => [
        ja,
      ];

  factory LangSupport.from(String value) {
    return items.firstWhere((item) => item.rawValue == value,
        orElse: () => null);
  }
}
