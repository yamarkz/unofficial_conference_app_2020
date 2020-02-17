import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/search_screen/search_session_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/search_screen/search_speaker_screen.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: DroidKaigiColors.white,
      ),
      elevation: 0,
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          Container(
            width: 90,
            child: Tab(
              child: Text(
                Strings.of(context).session,
                style: const TextStyle(
                  color: DroidKaigiColors.white,
                ),
              ),
            ),
          ),
          Container(
            width: 90,
            child: Tab(
              child: Text(
                Strings.of(context).speaker,
                style: const TextStyle(
                  color: DroidKaigiColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      children: <Widget>[
        SearchSessionScreen(),
        SearchSpeakerScreen(),
      ],
    );
  }
}
