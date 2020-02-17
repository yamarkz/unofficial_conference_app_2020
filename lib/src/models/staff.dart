import 'package:flutter/material.dart';

class Staff {
  final int id;
  final String name;
  final String icon;
  final String profileUrl;
  final int sort;

  const Staff({
    @required this.id,
    @required this.name,
    @required this.icon,
    @required this.profileUrl,
    @required this.sort,
  });

  factory Staff.fromJson(dynamic json) {
    return Staff(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      profileUrl: json['profileUrl'],
      sort: json['sort'],
    );
  }
}
