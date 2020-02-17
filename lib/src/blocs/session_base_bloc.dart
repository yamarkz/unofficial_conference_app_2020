import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/blocs/auth_bloc.dart';
import 'package:unofficial_conference_app_2020/src/blocs/favorite_bloc.dart';
import 'package:unofficial_conference_app_2020/src/models/session.dart';
import 'package:unofficial_conference_app_2020/src/resources/firestore/firestore_api.dart';
import 'package:unofficial_conference_app_2020/src/resources/repository/favorite_repository.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class SessionBaseBloc {
  final Session session;

  SessionBaseBloc({this.session}) {
    _load();
  }

  void dispose() {
    changeFavoriteSubject.close();
  }

  void _load() async {
    final user = AuthBloc.shared.firebaseUser;
    try {
      isFavorite = await FirestoreApi().find(user.uid, session.id);
      changeFavoriteSubject.sink.add(isFavorite);
    } on Exception catch (e) {
      print(e);
      // todo: error handling
    }
  }

  bool isFavorite = false;

  final changeFavoriteSubject = BehaviorSubject<bool>.seeded(false);
  Observable<bool> get changeFavoriteStream => changeFavoriteSubject.stream;

  void favorite() async {
    isFavorite = !isFavorite;
    final user = AuthBloc.shared.firebaseUser;
    try {
      await FavoriteRepository()
          .toggleFavorite(session.id, user.uid, isFavorite);
      changeFavoriteSubject.sink.add(isFavorite);
      FavoriteBloc.shared.updateFavorite(Tuple2(session.id, isFavorite));
    } on Exception catch (e) {
      print(e);
      // todo: error handling
    }
  }
}
