import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class SettingsScreen extends StatelessWidget {
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
        Strings.of(context).settings,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<ThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Theme',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: DroidKaigiColors.lightBlue300,
              ),
            ),
          ),
          SwitchListTile(
            title: Text(
              'DarkTheme',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            value: bloc.isDark,
            onChanged: bloc.changeTheme,
          ),
        ],
      ),
    );
  }
}
