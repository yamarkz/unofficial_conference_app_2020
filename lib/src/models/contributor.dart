import 'package:flutter/material.dart';

class Contributor {
  final int id;
  final String name;
  final String iconUrl;
  final String profileUrl;
  final int sort;

  const Contributor({
    @required this.id,
    @required this.name,
    @required this.iconUrl,
    @required this.profileUrl,
    @required this.sort,
  });

  factory Contributor.fromJson(Map<dynamic, dynamic> json) {
    return Contributor(
      id: json['id'],
      name: json['username'],
      iconUrl: json['iconUrl'],
      profileUrl: json['profileUrl'],
      sort: json['sort'],
    );
  }
}
