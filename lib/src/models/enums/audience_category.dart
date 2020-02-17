enum AudienceCategoryType {
  beginners,
  unspecified,
}

class AudienceCategory {
  final String rawValue;
  final AudienceCategoryType type;
  AudienceCategory._(this.rawValue, this.type);

  static AudienceCategory beginners =
      AudienceCategory._('初心者歓迎', AudienceCategoryType.beginners);

  static AudienceCategory unspecified =
      AudienceCategory._('指定無し', AudienceCategoryType.unspecified);

  static List<AudienceCategory> get items => [
        beginners,
        unspecified,
      ];

  factory AudienceCategory.from(String value) {
    return items.firstWhere((item) => item.rawValue == value,
        orElse: () => null);
  }
}
