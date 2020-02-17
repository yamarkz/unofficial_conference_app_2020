import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/models/speaker.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/session_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SearchSpeakerScreenBloc {
  SearchSpeakerScreenBloc() {
    isFinishFirstLoad = true;
    load();
  }

  void dispose() {
    speakersSubject.close();
  }

  final speakersSubject = PublishSubject<Tuple2<List<Speaker>, bool>>();
  Observable<Tuple2<List<Speaker>, bool>> get speakersStream =>
      speakersSubject.stream;

  final speakers = <Speaker>[];

  bool isLoading = false;
  bool isFinishFirstLoad = false;

  Tuple2<List<Speaker>, bool> get speakersValue =>
      Tuple2(speakers, isLoading || !isFinishFirstLoad);

  void load() async {
    isLoading = true;
    try {
      final sessionContents = await SessionRepository().getSessionContents();
      speakers.addAll(sessionContents.speakers);
      isLoading = false;
      speakersSubject.sink.add(speakersValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      isLoading = false;
    }
  }
}
