import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unofficial_conference_app_2020/src/resources/api/base/api_request.dart';

class StaffsApi extends ApiRequest<StaffsApiResponse> {
  String get path => '/committee_members';

  StaffsApiResponse getResponse(http.Response response) {
    return StaffsApiResponse.fromJson(jsonObjectFromResponse(response));
  }
}

class StaffsApiResponse {
  final List<dynamic> staffs;

  StaffsApiResponse({
    @required this.staffs,
  });

  factory StaffsApiResponse.fromJson(dynamic data) {
    return StaffsApiResponse(
      staffs: data,
    );
  }
}
