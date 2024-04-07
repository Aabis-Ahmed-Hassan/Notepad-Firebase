import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  var _fbAuth = FirebaseAuth.instance;

  Future<void> loginUser(String email, String password) async {
    await _fbAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<String> signUpUser(String email, String password) async {
    UserCredential currentUser = await _fbAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return currentUser.user!.uid;
  }
}
