enum SponsorCategoryTypeType {
  platinum,
  gold,
  supporter,
  committeeSupport,
}

class SponsorCategoryType {
  final String rawValue;
  final SponsorCategoryTypeType type;
  SponsorCategoryType._(this.rawValue, this.type);

  static SponsorCategoryType platinum =
      SponsorCategoryType._('PLATINUM', SponsorCategoryTypeType.platinum);

  static SponsorCategoryType gold =
      SponsorCategoryType._('GOLD', SponsorCategoryTypeType.gold);

  static SponsorCategoryType supporter =
      SponsorCategoryType._('SUPPORTER', SponsorCategoryTypeType.supporter);

  static SponsorCategoryType committeeSupport = SponsorCategoryType._(
      'COMMITTEE_SUPPORT', SponsorCategoryTypeType.committeeSupport);

  static List<SponsorCategoryType> get items => [
        platinum,
        gold,
        supporter,
        committeeSupport,
      ];

  factory SponsorCategoryType.from(String value) {
    return items.firstWhere((item) => item.rawValue == value,
        orElse: () => null);
  }
}
