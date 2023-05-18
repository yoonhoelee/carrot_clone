import 'package:carrot_clone_app/WelcomeScreen/welcome_screen.dart';
import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {

  final String message;

  ErrorAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
            },
            child: const Center(
              child: Text('OK'),
            )),
      ],
    );
  }
}
