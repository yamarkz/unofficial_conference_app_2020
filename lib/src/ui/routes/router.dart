import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unofficial_conference_app_2020/src/blocs/contributor_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/favorite_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/search_screen/search_session_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/search_screen/search_speaker_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/tab_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/session_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/speaker_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/sponsor_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timeline_screen/timeline_day_one_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timeline_screen/timeline_day_two_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timeline_screen/timeline_my_plan_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timetable_tab_bloc.dart';
import 'package:unofficial_conference_app_2020/src/ui/main.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/fade_animation_route.dart';
import 'package:unofficial_conference_app_2020/src/ui/routes/standard_page_route.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/about_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/announce_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/contributor_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/floor_map_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/search_screen/search_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/session_feedback.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/session_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/settings_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/speaker_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/splash_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/sponsor_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/timetable_screen/timetable_screen.dart';
import 'package:unofficial_conference_app_2020/src/ui/screens/webview_screen.dart';

class RouteName {
  static const splash = '/';
  static const main = '/main';
  static const session = '/session';
  static const speaker = '/speaker';
  static const sponsor = '/sponsor';
  static const announcement = '/announcement';
  static const contributor = '/contributor';
  static const floorMap = '/floor_map';
  static const sessionFeedback = '/session_feedback';
  static const settings = '/settings';
  static const about = '/about';
  static const search = '/search';
  static const timetable = '/timetable';
  static const webview = '/webview';
}

class RouteParam {
  static const session = 'session';
  static const speaker = 'speaker';
  static const url = 'url';
}

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final params =
        (settings.arguments is Map) ? settings.arguments as Map : null;
    switch (settings.name) {
      case RouteName.splash:
        return FadeAnimationRoute<void>(builder: (_) => SplashScreen());
      case RouteName.main:
        return StandardPageRoute<void>(
          builder: (_) => MultiProvider(
            providers: [
              Provider<TabBloc>(
                create: (context) => TabBloc(),
                dispose: (_, bloc) => bloc.dispose(),
              ),
              Provider<FavoriteBloc>(
                create: (context) => FavoriteBloc(),
                dispose: (_, bloc) => bloc.dispose(),
              ),
              Provider<TimelineDayOneScreenBloc>(
                create: (context) => TimelineDayOneScreenBloc(
                  tabType: TabType.day1,
                ),
                dispose: (_, bloc) => bloc.dispose(),
              ),
              Provider<TimelineDayTwoScreenBloc>(
                create: (context) => TimelineDayTwoScreenBloc(
                  tabType: TabType.day2,
                ),
                dispose: (_, bloc) => bloc.dispose(),
              ),
              Provider<TimelineMyPlanScreenBloc>(
                create: (context) => TimelineMyPlanScreenBloc(
                  tabType: TabType.myPlan,
                ),
                dispose: (_, bloc) => bloc.dispose(),
              ),
            ],
            child: Main(),
          ),
        );
      case RouteName.session:
        return StandardPageRoute<void>(
          builder: (_) => Provider<SessionScreenBloc>(
            create: (context) => SessionScreenBloc(
              session: params[RouteParam.session],
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: SessionScreen(),
          ),
        );
      case RouteName.speaker:
        return StandardPageRoute<void>(
          builder: (_) => Provider<SpeakerScreenBloc>(
            create: (context) => SpeakerScreenBloc(
              speakerId: params[RouteParam.speaker].id,
            ),
            dispose: (_, bloc) => bloc.dispose(),
            child: SpeakerScreen(),
          ),
        );
      case RouteName.sponsor:
        return StandardPageRoute<void>(
          builder: (_) => Provider<SponsorScreenBloc>(
            create: (context) => SponsorScreenBloc(),
            dispose: (_, bloc) => bloc.dispose(),
            child: SponsorScreen(),
          ),
        );
      case RouteName.floorMap:
        return StandardPageRoute<void>(builder: (_) => FloorMapScreen());
      case RouteName.announcement:
        return StandardPageRoute<void>(builder: (_) => AnnouncementScreen());
      case RouteName.contributor:
        return StandardPageRoute<void>(
          builder: (_) => Provider<ContributorScreenBloc>(
            create: (context) => ContributorScreenBloc(),
            dispose: (_, bloc) => bloc.dispose(),
            child: ContributorScreen(),
          ),
        );
      case RouteName.sessionFeedback:
        return StandardPageRoute<void>(builder: (_) => SessionFeedbackScreen());
      case RouteName.settings:
        return StandardPageRoute<void>(builder: (_) => SettingsScreen());
      case RouteName.about:
        return StandardPageRoute<void>(builder: (_) => AboutScreen());
      case RouteName.search:
        return StandardPageRoute<void>(
          builder: (_) => MultiProvider(
            providers: [
              Provider<SearchSessionScreenBloc>(
                create: (context) => SearchSessionScreenBloc(),
                dispose: (_, bloc) => bloc.dispose(),
              ),
              Provider<SearchSpeakerScreenBloc>(
                create: (context) => SearchSpeakerScreenBloc(),
                dispose: (_, bloc) => bloc.dispose(),
              ),
            ],
            child: SearchScreen(),
          ),
        );
      case RouteName.timetable:
        return StandardPageRoute<void>(
          builder: (_) => Provider<TimetableTabBloc>(
            create: (context) => TimetableTabBloc(),
            dispose: (_, bloc) => bloc.dispose(),
            child: TimetableScreen(),
          ),
        );
      case RouteName.webview:
        return StandardPageRoute<void>(
          builder: (_) => WebviewScreen(
            url: params[RouteParam.url],
          ),
        );
      default:
        return null;
    }
  }
}
