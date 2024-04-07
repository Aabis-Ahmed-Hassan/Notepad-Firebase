import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/view/login.dart';
import 'package:notepad_with_firebase/view_model/auth_methods.dart';

import '../utils/components/my_button.dart';
import '../utils/constants/colors.dart';
import '../utils/utils.dart';
import 'home_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  bool _loading = false;
  Future<void> signup(String email, String password) async {
    setState(() {
      _loading = true;
    });

    await AuthMethods().signUpUser(email, password);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                hintText: 'Please enter your email',
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                label: Text('Password'),
                hintText: 'Please enter your password',
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            MyButton(
              title: 'Sign Up',
              onTap: () async {
                await signup(
                  _emailController.text,
                  _passwordController.text,
                ).then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }).onError((error, stackTrace) {
                  print(error);
                  Utils.showSnackBar(context, 'Error');
                });
              },
              loading: _loading,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("Already have an account? Log In"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
