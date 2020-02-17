import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/models/category.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/lang.dart';
import 'package:unofficial_conference_app_2020/src/models/room.dart';
import 'package:unofficial_conference_app_2020/src/models/speaker.dart';
import 'package:unofficial_conference_app_2020/src/utility/type_utils.dart';

class Session {
  final String id;
  final String title;
  final String description;
  final DateTime startsAt;
  final DateTime endsAt;
  final int dayNumber;
  final bool isServiceSession;
  final bool isPlenumSession;
  final int roomId;
  final String targetAudience;
  final SessionLang language;
  final int lengthInMinutes;
  final int sessionCategoryItemId;
  final bool interpretationTarget;
  final String sessionType;
  final String videoUrl;
  final String slideUrl;
  final List<Speaker> speakers;
  final List<String> speakerIds;
  final Room room;
  final Category category;
  final bool isFavorited;

  const Session({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.startsAt,
    @required this.endsAt,
    @required this.dayNumber,
    @required this.isServiceSession,
    @required this.isPlenumSession,
    @required this.roomId,
    @required this.targetAudience,
    @required this.language,
    @required this.lengthInMinutes,
    @required this.sessionCategoryItemId,
    @required this.interpretationTarget,
    @required this.sessionType,
    @required this.videoUrl,
    @required this.slideUrl,
    @required this.speakers,
    @required this.speakerIds,
    @required this.room,
    @required this.category,
    @required this.isFavorited,
  });

  String startHourMinute() {
    if (startsAt.minute == 0) return "${startsAt.hour}:00";
    return "${startsAt.hour}:${startsAt.minute}";
  }

  String endHourMinute() {
    if (endsAt.minute == 0) return "${endsAt.hour}:00";
    return "${endsAt.hour}:${endsAt.minute}";
  }

  String sessionDate() {
    return "${startsAt.month}月${startsAt.day}日";
  }

  String sessionScale() {
    return "${endsAt.difference(startsAt).inMinutes.toString()}min";
  }

  String sessionTimeSpan() {
    return "${sessionDate()} ${startHourMinute()} - ${endHourMinute()}";
  }

  static int calcDayNumber(String startsAt) {
    return datetimeOrNull(startsAt).day == 20 ? 1 : 2;
  }

  factory Session.fromJson(
    Map<dynamic, dynamic> json,
    dynamic resources,
  ) {
    final List<String> targetIds = json['speakers'].cast<String>();
    final List<dynamic> speakers = resources.speakers
        .where(
          (dynamic speaker) => targetIds.contains(speaker['id']),
        )
        .toList();

    final dynamic room = resources.rooms.firstWhere(
      (dynamic room) => room['id'] == json['roomId'],
    );

    final dynamic category = resources.categories.firstWhere(
        (dynamic category) => category['id'] == json['sessionCategoryItemId'],
        orElse: () => null);

    return Session(
      id: json['id'],
      title: json['title']['ja'],
      description: json['description'],
      startsAt: datetimeOrNull(json['startsAt']),
      endsAt: datetimeOrNull(json['endsAt']),
      dayNumber: calcDayNumber(json['startsAt']),
      isServiceSession: json['isServiceSession'],
      isPlenumSession: json['isPlenumSession'],
      roomId: json['roomId'],
      targetAudience: json['targetAudience'],
      language: SessionLang.fromString(json['language']),
      lengthInMinutes: json['lengthInMinutes'],
      sessionCategoryItemId: json['sessionCategoryItemId'],
      interpretationTarget: json['interpretationTarget'],
      sessionType: json['sessionType'],
      videoUrl: json['asset']['videoUrl'],
      slideUrl: json['asset']['slideUrl'],
      speakerIds: json['speakers'].cast<String>(),
      speakers: speakers
          .map(
            (dynamic speaker) => Speaker.fromJson(speaker),
          )
          .toList(),
      room: Room.fromJson(room),
      category: Category.fromJson(category),
      isFavorited: false,
    );
  }
}
