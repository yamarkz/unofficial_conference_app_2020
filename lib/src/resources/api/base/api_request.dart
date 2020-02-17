import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unofficial_conference_app_2020/src/resources/api/base/api_error.dart';
import 'package:unofficial_conference_app_2020/src/utility/log.dart';

enum HttpMethod { get, post, put, patch, delete, head }

abstract class ApiRequest<T> {
  final endPoint = 'https://api.droidkaigi.jp/2020';
  String get url => endPoint + path;
  String get path => null;
  HttpMethod get method => HttpMethod.get;

  Future<Map<String, String>> get headers async {
    return {};
  }

  Map<String, Object> get body => null;
  String get contentType => 'application/json';
  Encoding get encoding => Encoding.getByName('utf-8');
  bool get isPostMethod => [
        HttpMethod.post,
        HttpMethod.put,
        HttpMethod.patch,
      ].contains(method);

  T getResponse(http.Response response);

  Future<T> execute() async {
    try {
      final response = await _execute();
      if (response.statusCode == 403 && response.body.contains('CloudFront')) {
        throw ApiException(response.body,
            statusCode: ApiException.cloudFrontError);
      }
      return getResponse(response);
    } on ApiException catch (_) {
      rethrow;
    } on Exception catch (e) {
      throw ApiException(e.toString(),
          statusCode: ApiException.codeNetworkError);
    }
  }

  Future<http.Response> _execute() async {
    final url = this.url;
    final headers = await this.headers;
    final body = json.encode(this.body);
    LOG('[HEADERS]: $headers');
    switch (method) {
      case HttpMethod.get:
        LOG('[GET]: $url\n');
        return http.get(url, headers: headers);
      case HttpMethod.post:
        LOG('[POST]: $url');
        LOG('[BODY]: $body\n\n');
        return http.post(url, body: body, headers: headers, encoding: encoding);
      case HttpMethod.put:
        LOG('[PUT]: $url');
        LOG('[BODY]: $body\n\n');
        return http.put(url, body: body, headers: headers, encoding: encoding);
      case HttpMethod.patch:
        LOG('[PATCH]: $url');
        LOG('[BODY]: $body\n\n');
        return http.patch(url,
            body: body, headers: headers, encoding: encoding);
      case HttpMethod.delete:
        LOG('[DELETE]: $url');
        return http.delete(url, headers: headers);
      case HttpMethod.head:
        LOG('[HEAD]: $url');
        return http.head(url, headers: headers);
      default:
        return null;
    }
  }

  dynamic jsonObjectFromResponse(http.Response response) {
    try {
      return json.decode(response.body);
    } on Exception catch (e) {
      final error = ApiException(e.toString());
      error.statusCode = response.statusCode;
      throw error;
    }
  }
}
