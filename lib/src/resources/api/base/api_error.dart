class ApiException implements Exception {
  final String message;
  final List<String> errors;
  int statusCode;

  static const codeNetworkError = -100;
  static const cloudFrontError = -101;

  ApiException(this.message, {this.errors, this.statusCode});

  @override
  String toString() {
    if (errors != null && errors.isNotEmpty) {
      return 'ApiError: $message ($statusCode), ${errors.join(',')}';
    } else {
      return 'ApiError: $message ($statusCode)';
    }
  }

  String get error => errors?.join('\n');

  bool get isNetworkError => statusCode == codeNetworkError;
  bool get isCloudFrontError => statusCode == cloudFrontError;
  bool get isServerError => !isNetworkError;
}
