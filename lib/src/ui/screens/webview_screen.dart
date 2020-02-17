import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewScreen extends StatelessWidget {
  final String url;

  WebviewScreen({this.url});

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: _buildAppBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
    );
  }
}
