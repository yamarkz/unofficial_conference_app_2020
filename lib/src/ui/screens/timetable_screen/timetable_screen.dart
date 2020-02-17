import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timetable_tab_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timetable_tab_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/l10n/strings.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/timetable_screen/timetable_tab_screen.dart';

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        Strings.of(context).timetable,
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          Container(
            width: 90,
            child: const Tab(text: 'App bars'),
          ),
          Container(
            width: 90,
            child: const Tab(text: 'Backdrop'),
          ),
          Container(
            width: 90,
            child: const Tab(text: 'Cards'),
          ),
          Container(
            width: 90,
            child: const Tab(text: 'Dialogs'),
          ),
          Container(
            width: 90,
            child: const Tab(text: 'Pickers'),
          ),
          Container(
            width: 90,
            child: const Tab(text: 'Sliders'),
          ),
          Container(
            width: 90,
            child: const Tab(text: 'Tabs'),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<TimetableTabBloc>(builder: (context, bloc, _) {
      bloc.tabController = DefaultTabController.of(context);
      return TabBarView(
        children: <Widget>[
          Provider<TimetableTabScreenBloc>(
            create: (context) => TimetableTabScreenBloc(
              tabType: TimetableTabType.appBars,
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: TimetableTabScreen(),
          ),
          Provider<TimetableTabScreenBloc>(
            create: (context) => TimetableTabScreenBloc(
              tabType: TimetableTabType.backdrop,
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: TimetableTabScreen(),
          ),
          Provider<TimetableTabScreenBloc>(
            create: (context) => TimetableTabScreenBloc(
              tabType: TimetableTabType.cards,
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: TimetableTabScreen(),
          ),
          Provider<TimetableTabScreenBloc>(
            create: (context) => TimetableTabScreenBloc(
              tabType: TimetableTabType.dialogs,
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: TimetableTabScreen(),
          ),
          Provider<TimetableTabScreenBloc>(
            create: (context) => TimetableTabScreenBloc(
              tabType: TimetableTabType.pickers,
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: TimetableTabScreen(),
          ),
          Provider<TimetableTabScreenBloc>(
            create: (context) => TimetableTabScreenBloc(
              tabType: TimetableTabType.sliders,
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: TimetableTabScreen(),
          ),
          Provider<TimetableTabScreenBloc>(
            create: (context) => TimetableTabScreenBloc(
              tabType: TimetableTabType.tabs,
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: TimetableTabScreen(),
          ),
        ],
      );
    });
  }
}
