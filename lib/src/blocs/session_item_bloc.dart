import 'dart:async';

import 'package:unofficial_conference_app_2020/src/blocs/favorite_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/session_base_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';

class SessionItemBloc extends SessionBaseBloc {
  final Session session;

  StreamSubscription _updateFavoritesSubscription;

  SessionItemBloc({this.session}) : super(session: session) {
    _updateFavoritesSubscription = FavoriteBloc.shared.updateFavoritesStream
        ?.where((e) => e.value1 == session.id)
        ?.listen((e) {
      isFavorite = e.value2;
      changeFavoriteSubject.sink.add(isFavorite);
    });
  }

  @override
  void dispose() {
    _updateFavoritesSubscription.cancel();
    super.dispose();
  }
}
