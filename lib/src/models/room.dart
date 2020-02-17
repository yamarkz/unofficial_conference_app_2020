import 'package:flutter/material.dart';

class Room {
  final int id;
  final String name;
  final int sort;

  const Room({
    @required this.id,
    @required this.name,
    @required this.sort,
  });

  factory Room.fromJson(Map<dynamic, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name']['ja'],
      sort: json['sort'],
    );
  }
}
