import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unofficial_conference_app_2020/src/resources/api/base/api_request.dart';

class SessionsApi extends ApiRequest<SessionsApiResponse> {
  String get path => '/timetable';

  SessionsApiResponse getResponse(http.Response response) {
    return SessionsApiResponse.fromJson(jsonObjectFromResponse(response));
  }
}

class SessionsApiResponse {
  final List<dynamic> sessions;
  final List<dynamic> rooms;
  final List<dynamic> speakers;
  final List<dynamic> categories;
  final List<dynamic> languages;

  SessionsApiResponse({
    @required this.sessions,
    @required this.rooms,
    @required this.speakers,
    @required this.categories,
    @required this.languages,
  });

  factory SessionsApiResponse.fromJson(Map<String, dynamic> data) {
    return SessionsApiResponse(
      sessions: data['sessions'],
      rooms: data['rooms'],
      speakers: data['speakers'],
      categories: data['categories'][2]['items'],
      languages: data['categories'][1]['items'],
    );
  }
}
