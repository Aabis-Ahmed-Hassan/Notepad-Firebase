import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/firebase_options.dart';
import 'package:notepad_with_firebase/view/splash_screen.dart';
import 'package:notepad_with_firebase/view_model/home_provider.dart';
import 'package:notepad_with_firebase/view_model/login_provider.dart';
import 'package:notepad_with_firebase/view_model/signup_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var _fbAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
