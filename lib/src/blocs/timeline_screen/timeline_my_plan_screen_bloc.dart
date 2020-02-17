import 'dart:async';

import 'package:unofficial_conference_app_2020/src/blocs/auth_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/favorite_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/tab_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/timeline_screen/timeline_screen_bloc.dart';
import 'package:unofficial_conference_app_2020/src/resources/firestore/firestore_api.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/session_repository.dart';

class TimelineMyPlanScreenBloc extends TimelineScreenBloc {
  StreamSubscription _updateFavoritesSubscription;

  TimelineMyPlanScreenBloc({TabType tabType})
      : super(day: TabTypeHelper.day(tabType)) {
    _updateFavoritesSubscription =
        FavoriteBloc.shared.updateFavoritesStream.listen((v) {
      _shouldReload = true;
      if (!_suspended) {
        _loadIfNeeded();
      }
    });
    TabBloc.shared.changeIndexStream.listen((index) {
      TabTypeHelper.index(tabType) == index ? _resume() : _pause();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _updateFavoritesSubscription?.cancel();
  }

  bool _shouldReload = true;
  bool _suspended = true;

  void _pause() {
    _suspended = true;
  }

  void _resume() {
    _suspended = false;
    _loadIfNeeded();
  }

  void _loadIfNeeded() {
    if (!_shouldReload) return;
    _shouldReload = false;
    if (!isFinishFirstLoad) {
      firstLoad();
    } else {
      filterLoad();
    }
  }

  @override
  void load() async {
    if (isLoading) return;
    isLoading = true;
    final sessionContents = await SessionRepository().getSessionContents();
    final user = AuthBloc.shared.firebaseUser;
    try {
      final favorites = await FirestoreApi().findAll(user.uid);
      final favoriteIds = (favorites..removeWhere((k, v) => v == false)).keys;
      final favoriteSessions = sessionContents.sessions
          .where((session) => favoriteIds.contains(session.id));
      sessions.addAll(favoriteSessions);
      rooms.addAll(sessionContents.rooms);
      categories.addAll(sessionContents.categories);
      langs.addAll(sessionContents.langs);
      isLoading = false;
      sessionCount = sessionsValue.value1.length;
      sessionCountSubject.sink.add(sessionCount);
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

  @override
  void filterLoad() async {
    if (isLoading) return;
    isLoading = true;
    sessions.clear();
    sessionsSubject.sink.add(sessionsValue);
    try {
      final sessionContents = await SessionRepository().getSessionContents();
      final filteredSessions =
          sessionContents.sessions.where((session) => filters.isPass(session));
      final user = AuthBloc.shared.firebaseUser;
      final favorites = await FirestoreApi().findAll(user.uid);
      final favoriteIds = (favorites..removeWhere((k, v) => v == false)).keys;
      final favoriteSessions =
          filteredSessions.where((session) => favoriteIds.contains(session.id));
      sessions.addAll(favoriteSessions);
      isLoading = false;
      sessionCount = sessionsValue.value1.length;
      sessionCountSubject.sink.add(sessionCount);
      sessionsSubject.sink.add(sessionsValue);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
      isLoading = false;
    }
  }
}
