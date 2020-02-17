import 'package:unofficial_conference_app_2020/src/models/category.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/lang.dart';
import 'package:unofficial_conference_app_2020/src/models/room.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/models/session_contents.dart';
import 'package:unofficial_conference_app_2020/src/models/speaker.dart';
import 'package:unofficial_conference_app_2020/src/resources/api/session_api.dart';

class SessionRepository {
  static SessionRepository _shared;
  static SessionRepository get shared => _shared;
  factory SessionRepository() => _shared ??= SessionRepository._();
  SessionRepository._();

  final sessions = <Session>[];
  final categories = <Category>[];
  final speakers = <Speaker>[];
  final rooms = <Room>[];
  final langs = <Lang>[];

  SessionContents sessionContents;

  Future<SessionContents> getSessionContents() async {
    if (sessionContents != null) return sessionContents;

    try {
      final response = await SessionsApi().execute();

      if (sessions.length == 0) {
        sessions.addAll(
          response.sessions.map(
            (dynamic res) => Session.fromJson(res, response),
          ),
        );
      }
      if (speakers.length == 0) {
        speakers.addAll(
          response.speakers.map(
            (dynamic res) => Speaker.fromJson(res),
          ),
        );
      }
      if (rooms.length == 0) {
        rooms.addAll(
          response.rooms.map(
            (dynamic res) => Room.fromJson(res),
          ),
        );
      }
      if (categories.length == 0) {
        categories.addAll(
          response.categories.map(
            (dynamic res) => Category.fromJson(res),
          ),
        );
      }
      if (langs.length == 0) {
        langs.addAll(
          response.languages.map(
            (dynamic res) => Lang.fromJson(res),
          ),
        );
      }

      sessionContents = SessionContents(
        sessions: sessions,
        speakers: speakers,
        rooms: rooms,
        langs: langs,
        categories: categories,
      );

      return sessionContents;
    } on Exception catch (error) {
      print(error);
      return sessionContents;
    }
  }
}
