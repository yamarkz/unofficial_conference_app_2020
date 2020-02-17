import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timetable_tab_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/session_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class TimetableTabScreenBloc {
  final TimetableTabType tabType;

  TimetableTabScreenBloc({this.tabType}) {
    TimetableTabBloc.shared.changeIndexStream.listen((index) {
      if (TimetableTabTypeHelper.index(tabType) == index) {
        firstLoad();
      }
    });
  }

  void dispose() {
    sessionsSubject.close();
  }

  final sessionsSubject = PublishSubject<Tuple2<List<Session>, bool>>();
  Observable<Tuple2<List<Session>, bool>> get sessionsStream =>
      sessionsSubject.stream;
  final sessions = <Session>[];

  bool isLoading = false;
  bool isFinishFirstLoad = false;
  int sessionCount = 0;

  Tuple2<List<Session>, bool> get sessionsValue =>
      Tuple2(sessions, isLoading || !isFinishFirstLoad);

  void firstLoad() {
    if (isFinishFirstLoad) return;
    isFinishFirstLoad = true;
    load();
  }

  void load() async {
    isLoading = true;
    try {
      final sessionContents = await SessionRepository().getSessionContents();
      final roomToSessionsMap = sessionContents.sessions.where((session) =>
          session.roomId == TimetableTabTypeHelper.roomId(tabType));
      sessions.addAll(roomToSessionsMap);
      isLoading = false;
      sessionsSubject.sink.add(sessionsValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      isLoading = false;
    }
  }
}
