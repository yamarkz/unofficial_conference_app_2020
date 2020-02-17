import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/announce_item.dart';

class AnnouncementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      title: Text(
        Strings.of(context).announcement,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        AnnounceItem(),
        AnnounceItem(),
      ],
    );
  }
}
