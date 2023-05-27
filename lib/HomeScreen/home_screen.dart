import 'package:carrot_clone_app/LoginScreen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.white],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0, 1],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Home Screen', style: TextStyle(
            color: Colors.black54,
            fontFamily: 'Signatra',
            fontSize: 30,
          ),),
          centerTitle: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0, 1],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
