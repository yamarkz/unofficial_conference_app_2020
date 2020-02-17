enum FloorMapType {
  floor_1,
  floor_5,
}

class FloorMap {
  final String rawValue;
  final FloorMapType type;
  FloorMap._(this.rawValue, this.type);

  static FloorMap floor_1 = FloorMap._('1F', FloorMapType.floor_1);

  static FloorMap floor_5 = FloorMap._('5F', FloorMapType.floor_5);

  static List<FloorMap> get items => [
        floor_1,
        floor_5,
      ];

  factory FloorMap.from(String value) {
    return items.firstWhere((item) => item.rawValue == value,
        orElse: () => null);
  }
}
