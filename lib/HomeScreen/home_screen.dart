import 'package:carrot_clone_app/LoginScreen/login_screen.dart';
import 'package:carrot_clone_app/ProfileScreen/profile_screen.dart';
import 'package:carrot_clone_app/SearchProduct/search_product.dart';
import 'package:carrot_clone_app/WelcomeScreen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../UploadAdScreen/upload_ad_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

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
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SearchProduct()));
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.search,
                  color: Colors.green,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.logout,
                  color: Colors.green,
                ),
              ),
            ),
          ],
          title: const Text(
            'Home Screen',
            style: TextStyle(
              color: Colors.black54,
              fontFamily: 'Signatra',
              fontSize: 30,
            ),
          ),
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
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Post',
          backgroundColor: Colors.black54,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => UploadAdScreen()));
          },
          child: const Icon(Icons.cloud_upload),
        ),
      ),
    );
  }
}
