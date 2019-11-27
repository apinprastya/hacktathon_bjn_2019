import 'package:firebase_auth/firebase_auth.dart';

class UserSession {
  static UserSession instance = UserSession();
  FirebaseUser user;

  init() async {
    user = await FirebaseAuth.instance.currentUser();
  }
}
