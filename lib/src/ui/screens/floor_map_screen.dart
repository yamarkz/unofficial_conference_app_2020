import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';

class FloorMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
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
        Strings.of(context).floorMap,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        width: 500,
        height: 300,
        child: Image.asset(
          'assets/images/floor_map.png',
          width: 500,
          height: 300,
        ),
      ),
    );
  }
}
