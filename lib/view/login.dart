import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/utils/components/my_button.dart';
import 'package:notepad_with_firebase/utils/utils.dart';
import 'package:notepad_with_firebase/view/signup.dart';
import 'package:notepad_with_firebase/view_model/auth_methods.dart';
import 'package:notepad_with_firebase/view_model/login_provider.dart';
import 'package:provider/provider.dart';

import '../utils/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // Future<void> login(
  //     String email, String password, LoadingProvider _loadingProvider) async {
  //   _loadingProvider.setLoading(true);
  //
  //   await AuthMethods().loginUser(email, password);
  //   _loadingProvider.setLoading(false);
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.text = '';
    _passwordController.text = '';
    _emailFocusNode.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    final _loadingProvider = Provider.of<LoginProvider>(context, listen: false);
    print('Login Screen');

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              focusNode: _emailFocusNode,
              controller: _emailController,
              onFieldSubmitted: (val) {
                Utils.changeFocus(_emailFocusNode, _passwordFocusNode, context);
              },
              decoration: InputDecoration(
                label: Text('Email'),
                hintText: 'Please enter your email',
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextFormField(
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              decoration: InputDecoration(
                label: Text('Password'),
                hintText: 'Please enter your password',
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Consumer<LoginProvider>(builder: (context, provider, child) {
              return MyButton(
                title: 'Log In',
                onTap: () async {
                  await AuthMethods(context).loginUser(
                      _emailController.text, _passwordController.text, context);
                },
                loading: _loadingProvider.loading,
              );
            }),
            SizedBox(
              height: height * 0.03,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("Don't have an account? Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
