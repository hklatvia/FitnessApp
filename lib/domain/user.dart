import 'package:firebase_auth/firebase_auth.dart';

class User1 {
  String? id;
  User1.fromFirebase(User user) {
    id = user.uid;
  }
}
