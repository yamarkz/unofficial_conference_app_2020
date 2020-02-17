import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/category.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/lang.dart';
import 'package:unofficial_conference_app_2020/src/models/room.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/models/speaker.dart';

class SessionContents {
  final List<Session> sessions;
  final List<Speaker> speakers;
  final List<Room> rooms;
  final List<Lang> langs;
  final List<Category> categories;

  const SessionContents({
    @required this.sessions,
    @required this.speakers,
    @required this.rooms,
    @required this.langs,
    @required this.categories,
  });
}
