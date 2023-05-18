import 'package:carrot_clone_app/DialogBox/error_dialog.dart';
import 'package:carrot_clone_app/DialogBox/loading_dialog.dart';
import 'package:carrot_clone_app/ForgetPassword/forget_password.dart';
import 'package:carrot_clone_app/LoginScreen/background.dart';
import 'package:carrot_clone_app/SignUpScreen/sign_up_screen.dart';
import 'package:carrot_clone_app/Widgets/already_have_an_account_check.dart';
import 'package:carrot_clone_app/Widgets/rounded_button.dart';
import 'package:carrot_clone_app/Widgets/rounded_input_field.dart';
import 'package:carrot_clone_app/Widgets/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    showDialog(
        context: context,
        builder: (_) {
          return LoadingAlertDialog(
            message: 'Please Wait',
          );
        });
    User? currentUser;
    await _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(message: error.message.toString());
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Image.asset(
              'assets/icons/login.png',
              height: size.height * 0.32,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedInputField(
              hintText: 'Email',
              icon: Icons.person,
              onChanged: (value) {
                _emailController.text = value;
              },
            ),
            const SizedBox(
              height: 6,
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _passwordController.text = value;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()));
                },
                child: const Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            RoundedButton(
              text: 'Login',
              press: () {},
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
                login: true,
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
