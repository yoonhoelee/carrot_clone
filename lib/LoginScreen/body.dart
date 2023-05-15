import 'package:carrot_clone_app/LoginScreen/background.dart';
import 'package:carrot_clone_app/Widgets/rounded_input_field.dart';
import 'package:carrot_clone_app/Widgets/rounded_password_field.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            const SizedBox(height: 6,),
            RoundedPasswordField(onChanged: (value){
              _passwordController.text = value;
            },),
          ],
        ),
      ),
    );
  }
}
