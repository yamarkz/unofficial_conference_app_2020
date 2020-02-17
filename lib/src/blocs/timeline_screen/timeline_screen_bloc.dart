import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/models/category.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/audience_category.dart';
import 'package:unofficial_conference_app_2020/src/models/enums/lang.dart';
import 'package:unofficial_conference_app_2020/src/models/filters.dart';
import 'package:unofficial_conference_app_2020/src/models/room.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/session_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

abstract class TimelineScreenBloc {
  final int day;

  TimelineScreenBloc({this.day});

  void dispose() {
    sessionsSubject.close();
    sessionCountSubject.close();
    roomsSubject.close();
    categoriesSubject.close();
    langsSubject.close();
    _resetSubject.close();
  }

  final sessionsSubject = PublishSubject<Tuple2<List<Session>, bool>>();
  Observable<Tuple2<List<Session>, bool>> get sessionsStream =>
      sessionsSubject.stream;

  final sessionCountSubject = PublishSubject<int>();
  Observable<int> get sessionCountStream => sessionCountSubject.stream;

  final roomsSubject = PublishSubject<Tuple2<List<Room>, bool>>();
  Observable<Tuple2<List<Room>, bool>> get roomsStream => roomsSubject.stream;

  final categoriesSubject = PublishSubject<Tuple2<List<Category>, bool>>();
  Observable<Tuple2<List<Category>, bool>> get categoriesStream =>
      categoriesSubject.stream;

  final langsSubject = PublishSubject<Tuple2<List<Lang>, bool>>();
  Observable<Tuple2<List<Lang>, bool>> get langsStream => langsSubject.stream;

  final _resetSubject = PublishSubject<bool>();
  PublishSubject<bool> get resetSubject => _resetSubject;

  final sessions = <Session>[];
  final rooms = <Room>[];
  final categories = <Category>[];
  final langs = <Lang>[];

  Tuple2<List<Session>, bool> get sessionsValue =>
      Tuple2(sessions, isLoading || !isFinishFirstLoad);

  Tuple2<List<Room>, bool> get roomsValue => Tuple2(rooms, isLoading);
  Tuple2<List<Category>, bool> get categoriesValue =>
      Tuple2(categories, isLoading);
  Tuple2<List<Lang>, bool> get langsValue => Tuple2(langs, isLoading);
  int get sessionCountValue => sessionCount;

  bool isLoading = false;
  bool isFinishFirstLoad = false;
  int sessionCount = 0;

  // ignore: prefer_const_constructors
  final filters = Filters(
    rooms: [],
    categories: [],
    langs: [],
    langSupports: [],
    audienceCategories: [],
  );

  void firstLoad() {
    if (isFinishFirstLoad) return;
    isFinishFirstLoad = true;
    load();
  }

  void load() async {
    isLoading = true;
    try {
      final sessionContents = await SessionRepository().getSessionContents();
      final dayToSessionsMap =
          sessionContents.sessions.where((session) => session.dayNumber == day);
      sessions.addAll(dayToSessionsMap);
      rooms.addAll(sessionContents.rooms);
      categories.addAll(sessionContents.categories);
      langs.addAll(sessionContents.langs);
      isLoading = false;
      sessionCount = sessionsValue.value1.length;
      sessionCountSubject.sink.add(sessionCountValue);
      sessionsSubject.sink.add(sessionsValue);
      roomsSubject.sink.add(roomsValue);
      categoriesSubject.sink.add(categoriesValue);
      langsSubject.sink.add(langsValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      isLoading = false;
    }
  }

  void filterLoad() async {
    if (isLoading) return;
    isLoading = true;
    sessions.clear();
    sessionsSubject.sink.add(sessionsValue);
    try {
      final sessionContents = await SessionRepository().getSessionContents();
      final filteredSessions =
          sessionContents.sessions.where((session) => filters.isPass(session));
      final daySessions =
          filteredSessions.where((session) => session.dayNumber == day);
      sessions.addAll(daySessions);
      isLoading = false;
      sessionCount = sessionsValue.value1.length;
      sessionCountSubject.sink.add(sessionCountValue);
      sessionsSubject.sink.add(sessionsValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      isLoading = false;
    }
  }

  void roomFilterChange(
    Room room,
    bool checked,
  ) {
    if (checked) {
      filters.rooms.add(room);
    } else {
      filters.rooms.remove(room);
    }
    filterLoad();
  }

  void categoryFilterChange(
    Category category,
    bool checked,
  ) {
    if (checked) {
      filters.categories.add(category);
    } else {
      filters.categories.remove(category);
    }
    filterLoad();
  }

  void langFilterChange(
    Lang lang,
    bool checked,
  ) {
    if (checked) {
      filters.langs.add(lang);
    } else {
      filters.langs.remove(lang);
    }
    filterLoad();
  }

  void audienceCategoryFilterChange(
    AudienceCategory audienceCategory,
    bool checked,
  ) {
    if (checked) {
      filters.audienceCategories.add(audienceCategory);
    } else {
      filters.audienceCategories.remove(audienceCategory);
    }
    filterLoad();
  }

  void resetFilterChange() {
    filters.rooms.clear();
    filters.categories.clear();
    filters.langs.clear();
    filters.audienceCategories.clear();
    filterLoad();
    _resetSubject.sink.add(true);
  }
}
