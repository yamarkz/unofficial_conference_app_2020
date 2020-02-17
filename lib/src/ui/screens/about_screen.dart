import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/standard_page_route.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class AboutScreen extends StatelessWidget {
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
        Strings.of(context).about,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bloc = Provider.of<ThemeBloc>(context);
    return ListView(
      children: <Widget>[
        Container(
          width: 500,
          height: 300,
          child: Image.asset(
            'assets/images/top_image.png',
            width: 500,
            height: 300,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'What is DroidKaigi?',
                style: Theme.of(context).textTheme.body1.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.white
                        : DroidKaigiColors.indigo900),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: Text(
                  'DroidKaigiはエンジニアが主役の\nAndroidカンファレンスです。\n'
                  'Android技術情報の共有とコミュニケーションを目的に、'
                  '2020年2月20日(木)、21日(金)の2日間開催します。',
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print('click');
                    },
                    child: Image.asset(
                      'assets/images/twitter_icon.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      print('click');
                    },
                    child: Image.asset(
                      'assets/images/youtube_icon.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      print('click');
                    },
                    child: Image.asset(
                      'assets/images/medium_icon.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              ListTile(
                title: Text(
                  Strings.of(context).access,
                  style: Theme.of(context).textTheme.body1,
                ),
                trailing: Icon(Icons.launch,
                    color: bloc.isDark
                        ? DroidKaigiColors.white
                        : Colors.grey[600]),
                onTap: () {
                  print('click');
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  Strings.of(context).staffList,
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  print('click');
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  Strings.of(context).privacyPolicy,
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  print('click');
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  Strings.of(context).license,
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  _showLicensePage(context);
                },
              ),
              const Divider(),
              ListTile(
                title: Text(
                  Strings.of(context).appVersion,
                  style: Theme.of(context).textTheme.body1,
                ),
                trailing: Text(
                  '1.2.0',
                  style: Theme.of(context).textTheme.body1,
                ),
                onTap: () {
                  print('click');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLicensePage(BuildContext context) async {
    final info = await PackageInfo.fromPlatform();
    Navigator.push(
      context,
      StandardPageRoute<void>(
        builder: (BuildContext context) => LicensePage(
          applicationName: 'DrodiKaigi App',
          applicationVersion: info.version,
          applicationIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              'assets/images/Logo.png',
              width: 100,
              height: 200,
            ),
          ),
          applicationLegalese: '',
        ),
      ),
    );
  }
}
