import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final int sort;

  const Category({
    @required this.id,
    @required this.name,
    @required this.sort,
  });

  factory Category.fromJson(Map<dynamic, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name']['ja'],
      sort: json['sort'],
    );
  }
}
