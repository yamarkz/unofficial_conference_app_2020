import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc {
  static AuthBloc _shared;
  static AuthBloc get shared => _shared;
  factory AuthBloc() => _shared ??= AuthBloc._();
  AuthBloc._();

  void dispose() {
    _shared = null;
  }

  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Future<bool> signIn() async {
    try {
      final result = await _firebaseAuth.signInAnonymously();
      firebaseUser = result.user;
      return true;
    } on Exception catch (error) {
      print(error);
      return false;
    }
  }
}
