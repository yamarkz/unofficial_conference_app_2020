enum AnnouncementTypeType {
  notification,
  alert,
  feedback,
}

class AnnouncementType {
  final String rawValue;
  final AnnouncementTypeType type;
  AnnouncementType._(this.rawValue, this.type);

  static AnnouncementType notification =
      AnnouncementType._('notification', AnnouncementTypeType.notification);

  static AnnouncementType alert =
      AnnouncementType._('alert', AnnouncementTypeType.alert);

  static AnnouncementType feedback =
      AnnouncementType._('feedback', AnnouncementTypeType.feedback);

  static List<AnnouncementType> get items => [
        notification,
        alert,
        feedback,
      ];

  factory AnnouncementType.from(String value) {
    return items.firstWhere((item) => item.rawValue == value,
        orElse: () => null);
  }
}
