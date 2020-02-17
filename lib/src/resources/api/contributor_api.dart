import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unofficial_conference_app_2020/src/resources/api/base/api_request.dart';

class ContributorsApi extends ApiRequest<ContributorsApiResponse> {
  String get path => '/contributors';

  ContributorsApiResponse getResponse(http.Response response) {
    return ContributorsApiResponse.fromJson(jsonObjectFromResponse(response));
  }
}

class ContributorsApiResponse {
  final List<dynamic> contributors;

  ContributorsApiResponse({
    @required this.contributors,
  });

  factory ContributorsApiResponse.fromJson(dynamic data) {
    return ContributorsApiResponse(
      contributors: data,
    );
  }
}
