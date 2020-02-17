import 'package:unofficial_conference_app_2020/src/blocs/tab_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timeline_screen/timeline_screen_bloc.dart';

class TimelineDayOneScreenBloc extends TimelineScreenBloc {
  TimelineDayOneScreenBloc({TabType tabType})
      : super(day: TabTypeHelper.day(tabType)) {
    TabBloc.shared.changeIndexStream.listen((index) {
      if (TabTypeHelper.index(tabType) == index) {
        firstLoad();
      }
    });
  }
}
