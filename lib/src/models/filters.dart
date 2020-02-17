import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/category.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/audience_category.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/lang.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/lang_support.dart';
import 'package:unofficial_conference_app_2020/src/models/room.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';

class Filters {
  final List<Room> rooms;
  final List<Category> categories;
  final List<Lang> langs;
  final List<LangSupport> langSupports;
  final List<AudienceCategory> audienceCategories;

  const Filters({
    @required this.rooms,
    @required this.categories,
    @required this.langs,
    @required this.langSupports,
    @required this.audienceCategories,
  });

  bool isPass(Session session) {
    if (!isFiltered()) return true;

    final roomFilterOk =
        rooms.map((room) => room.id).toList().contains(session.room.id);

    final categoryFilterOk = categories
        .map((category) => category.id)
        .toList()
        .contains(session.sessionCategoryItemId);

    final langFilterOk =
        langs.map((lang) => lang.rawValue).toList().contains(session.language);
    return roomFilterOk || categoryFilterOk || langFilterOk;
  }

  bool isFiltered() {
    return (rooms.length != 0 ||
        categories.length != 0 ||
        langs.length != 0 ||
        langSupports.length != 0 ||
        audienceCategories.length != 0);
  }
}
