import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/announcement_type.dart';

class Announcement {
  final int id;
  final String title;
  final String content;
  final DateTime publishedAt;
  final AnnouncementType type;

  const Announcement({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.publishedAt,
    @required this.type,
  });
}
