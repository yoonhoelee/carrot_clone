import 'dart:io';

import 'package:carrot_clone_app/DialogBox/error_dialog.dart';
import 'package:carrot_clone_app/ForgetPassword/forget_password.dart';
import 'package:carrot_clone_app/HomeScreen/home_screen.dart';
import 'package:carrot_clone_app/LoginScreen/login_screen.dart';
import 'package:carrot_clone_app/SignUpScreen/background.dart';
import 'package:carrot_clone_app/Widgets/already_have_an_account_check.dart';
import 'package:carrot_clone_app/Widgets/rounded_button.dart';
import 'package:carrot_clone_app/Widgets/rounded_input_field.dart';
import 'package:carrot_clone_app/Widgets/rounded_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/global_var.dart';

class SignUpBody extends StatefulWidget {
  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  File? _image;
  bool _isLoading = false;
  final signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userPhotoUrl = '';

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        _image = File(croppedImage.path);
      });
    }
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please Choose an Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _getFromCamera();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.camera,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.image,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void submitFormOnSignUp() async {
    final isValid = signUpFormKey.currentState!.validate();
    if (isValid) {
      if (_image == null) {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorAlertDialog(
                message: "Please pick an image",
              );
            });
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim().toLowerCase(),
            password: _passwordController.text.trim());
        final User? user = _auth.currentUser;
        uid = user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child(uid + '.jpg');
        await ref.putFile(_image!);
        userPhotoUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'userName': _nameController.text.trim(),
          'id': uid,
          'userNumber': _phoneController.text.trim(),
          'userEmail': _emailController.text.trim(),
          'userImage': userPhotoUrl,
          'time': DateTime.now(),
          'status': 'approved',
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        ErrorAlertDialog(message: error.toString(),);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SignUpBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: signUpFormKey,
              child: InkWell(
                onTap: () {
                  _showImageDialog();
                },
                child: CircleAvatar(
                  radius: screenWidth * 0.2,
                  backgroundColor: Colors.white24,
                  backgroundImage: _image == null ? null : FileImage(_image!),
                  child: _image == null
                      ? Icon(
                          Icons.camera_enhance,
                          size: screenWidth * 0.18,
                          color: Colors.black54,
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            RoundedInputField(
                hintText: 'Name',
                icon: Icons.person,
                onChanged: (value) {
                  _nameController.text = value;
                }),
            RoundedInputField(
                hintText: 'Email',
                icon: Icons.email,
                onChanged: (value) {
                  _emailController.text = value;
                }),
            RoundedInputField(
                hintText: 'Phone Number',
                icon: Icons.phone,
                onChanged: (value) {
                  _phoneController.text = value;
                }),
            RoundedPasswordField(onChanged: (value) {
              _passwordController.text = value;
            }),
            const SizedBox(
              height: 5,
            ),
            _isLoading
                ? Center(
                    child: Container(
                      width: 70,
                      height: 72,
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : RoundedButton(
                    text: 'Submit',
                    press: () {
                      // submit for signup
                      submitFormOnSignUp();
                    }),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()));
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
