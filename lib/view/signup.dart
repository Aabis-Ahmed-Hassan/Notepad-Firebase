import 'package:flutter/material.dart';
import 'package:notepad_with_firebase/view/login.dart';
import 'package:notepad_with_firebase/view_model/auth_methods.dart';
import 'package:notepad_with_firebase/view_model/signup_provider.dart';
import 'package:provider/provider.dart';

import '../utils/components/my_button.dart';
import '../utils/constants/colors.dart';
import '../utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.text = '';
    _passwordController.text = '';
    _emailFocusNode.dispose();
    _passwordController.dispose();
  }

  // Future<void> signup(
  //     String email, String password,  _loadingProvider) async {
  //   _loadingProvider.setLoading(true);
  //   await AuthMethods(context).signUpUser(email, password);
  //
  //   _loadingProvider.setLoading(false);
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;

    final _loadingProvider =
        Provider.of<SignupProvider>(context, listen: false);
    print('Signup Screen');
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
            Consumer<SignupProvider>(builder: (context, provider, child) {
              return MyButton(
                title: 'Sign Up',
                onTap: () async {
                  await AuthMethods(context).signUpUser(
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
