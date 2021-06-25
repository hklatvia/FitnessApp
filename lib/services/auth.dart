import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/domain/user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<User1?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return User1.fromFirebase(user!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User1?> registerInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return User1.fromFirebase(user!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<User1?> get currentUser {
    return _fAuth.authStateChanges().map((User? user) {
      return user != null ? User1.fromFirebase(user) : null;
    });
  }
}
