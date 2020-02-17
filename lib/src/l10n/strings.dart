import 'dart:ui';

import 'package:flutter/widgets.dart';

// ref: https://flutter.dev/docs/development/accessibility-and-localization/internationalization#an-alternative-class-for-the-apps-localized-resources
class Strings {
  Strings(this.locale);

  final Locale locale;

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  // todo: refactoring
  static Map<String, Map<String, String>> localizedValues = {
    'en': {
      "day": "DAY",
      "min": "min",
      "myPlan": "MY PLAN",
      "filter": "Filter",
      "reset": "Reset",
      "targetSession": "Session",
      "targetAudience": "Target Audience",
      "session": "Session",
      "speaker": "Speaker",
      "document": "Document",
      "movie": "Movie",
      "slide": "Slide",
      "readMore": "Read more",
      "map": "Map",
      "access": "Access",
      "staffList": "Staff List",
      "privacyPolicy": "Privacy Policy",
      "appVersion": "App Version",
      "license": "License",
      "settings": "Settings",
      "sponsors": "Sponsor",
      "contributors": "Contributor",
      "questionnaire": "Session Questionnaire",
      "allQuestionnaire": "All Questionnaire",
      "about": "What is DroidKaigi ?",
      "timeline": "Timeline",
      "announcement": "Announcement",
      "floorMap": "Floor Map",
      "timetable": "Timetable"
    },
    'ja': {
      "day": "DAY",
      "myPlan": "MY PLAN",
      "filter": "絞り込み",
      "reset": "リセット",
      "targetSession": "該当セッション",
      "min": "分",
      "targetAudience": "対象者",
      "session": "セッション",
      "speaker": "スピーカー",
      "document": "資料",
      "movie": "動画",
      "slide": "スライド",
      "readMore": "続きを読む",
      "map": "マップ",
      "access": "会場アクセス",
      "staffList": "スタッフリスト",
      "license": "ライセンス",
      "privacyPolicy": "プライバシーポリシー",
      "appVersion": "アプリバージョン",
      "settings": "設定",
      "sponsors": "スポンサー",
      "contributors": "コントリビューター",
      "questionnaire": "セッション アンケート",
      "allQuestionnaire": "全体アンケート",
      "about": "DroidKaigiとは",
      "timeline": "タイムライン",
      "announcement": "お知らせ",
      "floorMap": "フロアマップ",
      "timetable": "タイムテーブル"
    },
  };

  String get appName => localizedValues[locale.languageCode]['appName'];
  String get appDescription =>
      localizedValues[locale.languageCode]['appDescription'];
  String day(int day) => "${localizedValues[locale.languageCode]['day']} $day";
  String get myPlan => localizedValues[locale.languageCode]['myPlan'];
  String get filter => localizedValues[locale.languageCode]['filter'];
  String get reset => localizedValues[locale.languageCode]['reset'];
  String get targetSession =>
      localizedValues[locale.languageCode]['targetSession'];
  String min(int min) => "${localizedValues[locale.languageCode]['min']} $min";
  String get targetAudience =>
      localizedValues[locale.languageCode]['targetAudience'];
  String get session => localizedValues[locale.languageCode]['session'];
  String get speaker => localizedValues[locale.languageCode]['speaker'];
  String get document => localizedValues[locale.languageCode]['document'];
  String get movie => localizedValues[locale.languageCode]['movie'];
  String get slide => localizedValues[locale.languageCode]['slide'];
  String get readMore => localizedValues[locale.languageCode]['readMore'];
  String get map => localizedValues[locale.languageCode]['map'];
  String get access => localizedValues[locale.languageCode]['access'];
  String get staffList => localizedValues[locale.languageCode]['staffList'];
  String get license => localizedValues[locale.languageCode]['license'];
  String get privacyPolicy =>
      localizedValues[locale.languageCode]['privacyPolicy'];
  String get appVersion => localizedValues[locale.languageCode]['appVersion'];
  String get settings => localizedValues[locale.languageCode]['settings'];
  String get sponsors => localizedValues[locale.languageCode]['sponsors'];
  String get contributors =>
      localizedValues[locale.languageCode]['contributors'];
  String get questionnaire =>
      localizedValues[locale.languageCode]['questionnaire'];
  String get allQuestionnaire =>
      localizedValues[locale.languageCode]['allQuestionnaire'];
  String get about => localizedValues[locale.languageCode]['about'];
  String get timeline => localizedValues[locale.languageCode]['timeline'];
  String get announcement =>
      localizedValues[locale.languageCode]['announcement'];
  String get floorMap => localizedValues[locale.languageCode]['floorMap'];
  String get timetable => localizedValues[locale.languageCode]['timetable'];
}
