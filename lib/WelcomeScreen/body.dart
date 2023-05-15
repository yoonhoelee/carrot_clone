import 'package:carrot_clone_app/WelcomeScreen/background.dart';
import 'package:flutter/material.dart';

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WelcomeBackground(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Carrot Clone',
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontFamily: 'Signatra',
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Image.asset(
            'assets/icons/chat.png',
            height: size.height * 0.4,
          ),
        ],
      ),
    ));
  }
}
