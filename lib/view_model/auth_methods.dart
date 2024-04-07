import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  var _fbAuth = FirebaseAuth.instance;
  var _ref = FirebaseFirestore.instance.collection('Users');

  Future<void> loginUser(String email, String password) async {
    await _fbAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<String> signUpUser(String email, String password) async {
    UserCredential currentUser = await _fbAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    Map<String, dynamic> data = {
      'email': email,
      'uid': currentUser.user!.uid,
    };
    await _ref.doc(currentUser.user!.uid).set(data);

    return currentUser.user!.uid;
  }
}
