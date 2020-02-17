import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/session_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SearchSessionScreenBloc {
  SearchSessionScreenBloc() {
    isFinishFirstLoad = true;
    load();
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

  Tuple2<List<Session>, bool> get sessionsValue =>
      Tuple2(sessions, isLoading || !isFinishFirstLoad);

  void load() async {
    isLoading = true;
    try {
      final sessionContents = await SessionRepository().getSessionContents();
      sessions.addAll(sessionContents.sessions);
      isLoading = false;
      sessionsSubject.sink.add(sessionsValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      isLoading = false;
    }
  }
}
