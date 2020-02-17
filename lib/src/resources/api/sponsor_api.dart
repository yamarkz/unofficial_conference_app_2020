import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unofficial_conference_app_2020/src/resources/api/base/api_request.dart';

class SponsorsApi extends ApiRequest<SponsorsApiResponse> {
  String get path => '/sponsors';

  SponsorsApiResponse getResponse(http.Response response) {
    return SponsorsApiResponse.fromJson(jsonObjectFromResponse(response));
  }
}

class SponsorsApiResponse {
  final List<dynamic> sponsors;

  SponsorsApiResponse({
    @required this.sponsors,
  });

  factory SponsorsApiResponse.fromJson(List<dynamic> data) {
    return SponsorsApiResponse(
      sponsors: data,
    );
  }
}
