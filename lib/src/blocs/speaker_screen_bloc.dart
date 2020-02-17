import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/models/speaker.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/session_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SpeakerScreenBloc {
  final String speakerId;

  SpeakerScreenBloc({this.speakerId}) {
    _loadSpeaker();
    _loadSpeakerSession();
  }

  void dispose() {
    _sessionsSubject.close();
    _speakerSubject.close();
  }

  final _sessionsSubject = PublishSubject<Tuple2<List<Session>, bool>>();
  Observable<Tuple2<List<Session>, bool>> get sessionsStream =>
      _sessionsSubject.stream;

  Tuple2<List<Session>, bool> get sessionsValue =>
      Tuple2(_sessions, _isSessionsLoading);

  final _speakerSubject = PublishSubject<Tuple2<Speaker, bool>>();
  Observable<Tuple2<Speaker, bool>> get speakerStream => _speakerSubject.stream;

  Tuple2<Speaker, bool> get speakerValue => Tuple2(_speaker, _isSpeakerLoading);

  Speaker _speaker;
  final _sessions = <Session>[];
  bool _isSpeakerLoading = false;
  bool _isSessionsLoading = false;

  void _loadSpeaker() async {
    _isSpeakerLoading = true;
    try {
      final sessionContents = await SessionRepository().getSessionContents();
      _speaker = sessionContents.speakers
          .firstWhere((speaker) => speaker.id == speakerId);
      _isSpeakerLoading = false;
      _speakerSubject.sink.add(speakerValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      _isSpeakerLoading = false;
    }
  }

  void _loadSpeakerSession() async {
    _isSessionsLoading = true;
    try {
      final sessionContents = await SessionRepository().getSessionContents();
      final sessions = sessionContents.sessions.where((session) {
        return session.speakerIds.length != 0 &&
                session.speakerIds.contains(speakerId)
            ? true
            : false;
      });
      _sessions.addAll(sessions);
      _isSessionsLoading = false;
      _sessionsSubject.sink.add(sessionsValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      _isSpeakerLoading = false;
    }
  }
}
