import 'package:unofficial_conference_app_2020/src/resources/firestore/firestore_api.dart';

class FavoriteRepository {
  static FavoriteRepository _shared;
  static FavoriteRepository get shared => _shared;
  factory FavoriteRepository() => _shared ??= FavoriteRepository._();
  FavoriteRepository._();

  void toggleFavorite(String sessionId, String uid, bool favorite) {
    FirestoreApi().toggleFavorite(sessionId, uid, favorite);
  }
}
