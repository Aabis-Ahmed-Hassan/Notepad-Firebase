import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/view/home_screen.dart';
import 'package:notepad_with_firebase/view/login.dart';
import 'package:notepad_with_firebase/view_model/home_provider.dart';
import 'package:provider/provider.dart';

class SplashViewModel {
  User? _user = FirebaseAuth.instance.currentUser;

  void isLogin(BuildContext context) {
    if (_user != null) {
      Future.delayed(Duration(seconds: 2), () async {
        final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
        _homeProvider.refreshNotes();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      });
    }
  }
}
