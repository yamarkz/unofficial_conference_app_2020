import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {
  Future<Map<String, bool>> findAll(String userId) async {
    final result = <String, bool>{};
    final snapshots =
        Firestore.instance.collection("users/$userId/favorites").snapshots();

    final snapshot = await snapshots.first;
    snapshot.documents.forEach((DocumentSnapshot document) {
      final sessionId = document.documentID;
      bool favorite = document.data.values.toList()[0];
      result[sessionId] = favorite;
    });
    return Future.value(result);
  }

  // todo: refactoring
  Future<bool> find(String userId, String sessionId) async {
    final snapshots = Firestore.instance
        .document("users/$userId/favorites/$sessionId")
        .snapshots();

    final snapshot = await snapshots.first;
    if (snapshot.data != null) return snapshot.data.values.toList()[0];
    return false;
  }

  Future<void> toggleFavorite(
    String sessionId,
    String uid,
    bool favorite,
  ) async {
    final data = {"favorite": favorite};
    await Firestore.instance
        .collection("users/$uid/favorites")
        .document(sessionId)
        .setData(data);
  }
}
