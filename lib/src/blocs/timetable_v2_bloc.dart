import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/models/session_contents.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/session_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class TimetableV2Bloc {
  TimetableV2Bloc() {
    firstLoad();
  }
  void dispose() {
    sessionContentsSubject.close();
  }

  final sessionContentsSubject =
      PublishSubject<Tuple2<SessionContents, bool>>();
  Observable<Tuple2<SessionContents, bool>> get sessionContentsStream =>
      sessionContentsSubject.stream;

  SessionContents sessionContents;

  Tuple2<SessionContents, bool> get sessionContentsValue =>
      Tuple2(sessionContents, isLoading || !isFinishFirstLoad);

  bool isLoading = false;
  bool isFinishFirstLoad = false;

  void firstLoad() {
    if (isFinishFirstLoad) return;
    isFinishFirstLoad = true;
    load();
  }

  void load() async {
    isLoading = true;
    try {
      sessionContents = await SessionRepository().getSessionContents();
      isLoading = false;
      sessionContentsSubject.sink.add(sessionContentsValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      isLoading = false;
    }
  }
}
