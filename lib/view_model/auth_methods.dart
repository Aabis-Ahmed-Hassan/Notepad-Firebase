import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/utils/utils.dart';
import 'package:notepad_with_firebase/view/splash_screen.dart';
import 'package:notepad_with_firebase/view_model/signup_provider.dart';
import 'package:provider/provider.dart';

import 'login_provider.dart';

class AuthMethods {
  var _fbAuth = FirebaseAuth.instance;
  var _ref = FirebaseFirestore.instance.collection('Users');

  LoginProvider? _loginProvider;
  SignupProvider? _signupProvider;
  AuthMethods(BuildContext context) {
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _signupProvider = Provider.of<SignupProvider>(context, listen: false);
  }

  Future<void> loginUser(
      String email, String password, BuildContext context2) async {
    _loginProvider!.setLoading(true);

    await _fbAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.pushReplacement(
          context2, MaterialPageRoute(builder: (context2) => SplashScreen()));
    }).onError((error, stackTrace) {
      Utils.showSnackBar(context2, 'Error');
    });
    _loginProvider!.setLoading(false);
  }

  Future<void> signUpUser(
      String email, String password, BuildContext context) async {
    _signupProvider!.setLoading(true);

    UserCredential? currentUser = await _fbAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {})
        .onError((error, stackTrace) {
      _signupProvider!.setLoading(false);

      Utils.showSnackBar(context, 'Error');
    });

    if (currentUser != null) {
      Map<String, dynamic> data = {
        'email': email,
        'uid': currentUser!.user!.uid,
      };
      await _ref.doc(currentUser.user!.uid).set(data).then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));
      }).onError((error, stackTrace) {
        Utils.showSnackBar(context, 'Error');
      });

      _signupProvider!.setLoading(false);
    }
    // return currentUser.user!.uid;
  }
}
