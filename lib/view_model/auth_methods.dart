import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/utils/utils.dart';
import 'package:notepad_with_firebase/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'loading_provider.dart';

class AuthMethods {
  var _fbAuth = FirebaseAuth.instance;
  var _ref = FirebaseFirestore.instance.collection('Users');

  LoadingProvider? _loadingProvider;
  AuthMethods(BuildContext context) {
    _loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
  }

  Future<void> loginUser(
      String email, String password, BuildContext context2) async {
    _loadingProvider!.setLoading(true);

    await _fbAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.pushReplacement(
          context2, MaterialPageRoute(builder: (context2) => SplashScreen()));
    }).onError((error, stackTrace) {
      Utils.showSnackBar(context2, 'Error');
    });
    _loadingProvider!.setLoading(false);
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
