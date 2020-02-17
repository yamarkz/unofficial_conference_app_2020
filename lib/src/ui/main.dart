import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/tab_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/theme_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/router.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/timeline_screen/timeline_day_one_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/timeline_screen/timeline_day_two_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/timeline_screen/timeline_my_plan_screen.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

// navigator push rebuild bug
// ref: https://github.com/flutter/flutter/issues/11655
//
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(context),
        drawer: _buildDrawer(context),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<TabBloc>(builder: (context, bloc, _) {
      bloc.tabController = DefaultTabController.of(context);
      return TabBarView(
        children: <Widget>[
          TimelineDayOneScreen(),
          TimelineDayTwoScreen(),
          TimelineMyPlanScreen(),
        ],
      );
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/Logo_2.png',
            width: 23,
            height: 23,
          )
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.table_chart),
          onPressed: () {
            Navigator.of(context).pushNamed(RouteName.timetable);
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).pushNamed(RouteName.search);
          },
        ),
      ],
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          Container(
            width: 90,
            child: Tab(text: Strings.of(context).day(1)),
          ),
          Container(
            width: 90,
            child: Tab(text: Strings.of(context).day(2)),
          ),
          Container(
            width: 90,
            child: Tab(text: Strings.of(context).myPlan),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final bloc = Provider.of<ThemeBloc>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              width: 160,
              height: 60,
              child: Image.asset(
                'assets/images/Logo.png',
                width: 160,
                height: 60,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.event,
              color:
                  bloc.isDark ? DroidKaigiColors.indigo200 : Colors.grey[600],
            ),
            title: Text(
              Strings.of(context).timeline,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.indigo200
                        : Colors.grey[600],
                  ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.android,
              color:
                  bloc.isDark ? DroidKaigiColors.indigo200 : Colors.grey[600],
            ),
            title: Text(
              Strings.of(context).about,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.indigo200
                        : Colors.grey[600],
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.about);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color:
                  bloc.isDark ? DroidKaigiColors.indigo200 : Colors.grey[600],
            ),
            title: Text(
              Strings.of(context).announcement,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.indigo200
                        : Colors.grey[600],
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.announcement);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.location_on,
              color:
                  bloc.isDark ? DroidKaigiColors.indigo200 : Colors.grey[600],
            ),
            title: Text(
              Strings.of(context).floorMap,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.indigo200
                        : Colors.grey[600],
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.floorMap);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.business,
              color:
                  bloc.isDark ? DroidKaigiColors.indigo200 : Colors.grey[600],
            ),
            title: Text(
              Strings.of(context).sponsors,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.indigo200
                        : Colors.grey[600],
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.sponsor);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people,
              color:
                  bloc.isDark ? DroidKaigiColors.indigo200 : Colors.grey[600],
            ),
            title: Text(
              Strings.of(context).contributors,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.indigo200
                        : Colors.grey[600],
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.contributor);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color:
                  bloc.isDark ? DroidKaigiColors.indigo200 : Colors.grey[600],
            ),
            title: Text(
              Strings.of(context).settings,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.indigo200
                        : Colors.grey[600],
                  ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.settings);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.announcement,
              color:
                  bloc.isDark ? DroidKaigiColors.indigo200 : Colors.grey[600],
            ),
            title: Text(
              Strings.of(context).allQuestionnaire,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: bloc.isDark
                        ? DroidKaigiColors.indigo200
                        : Colors.grey[600],
                  ),
            ),
            onTap: () {
              print('tap');
            },
          ),
        ],
      ),
    );
  }
}
