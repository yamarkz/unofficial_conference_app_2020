import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/utility/tuple.dart';

class FavoriteBloc {
  static FavoriteBloc _shared;
  static FavoriteBloc get shared => _shared;
  factory FavoriteBloc() => _shared ??= FavoriteBloc._();
  FavoriteBloc._();

  void dispose() {
    _updateFavoritesSubject.close();
    _shared = null;
  }

  final _updateFavoritesSubject = PublishSubject<Tuple2<String, bool>>();
  Observable<Tuple2<String, bool>> get updateFavoritesStream =>
      _updateFavoritesSubject.stream;

  void updateFavorite(Tuple2<String, bool> value) {
    _updateFavoritesSubject.sink.add(value);
  }
}
