import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unofficial_conference_app_2020/src/resources/api/base/api_request.dart';

class AnnouncementsApi extends ApiRequest<AnnouncementsApiResponse> {
  // ja or en
  String get path => '/announcements/ja';

  AnnouncementsApiResponse getResponse(http.Response response) {
    return AnnouncementsApiResponse.fromJson(jsonObjectFromResponse(response));
  }
}

class AnnouncementsApiResponse {
  final Map<String, dynamic> announcements;

  AnnouncementsApiResponse({
    @required this.announcements,
  });

  factory AnnouncementsApiResponse.fromJson(dynamic data) {
    return AnnouncementsApiResponse(
      announcements: data[0],
    );
  }
}
