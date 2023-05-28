import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadAdScreen extends StatefulWidget {
  @override
  State<UploadAdScreen> createState() => _UploadAdScreenState();
}

class _UploadAdScreenState extends State<UploadAdScreen> {
  bool next = false;
  bool uploading = false;
  double val = 0;
  final List<File> _image = [];

  chooseImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }

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
          title: Text(
            next ? 'Please Write Item Info' : 'Choose Item Images',
            style: const TextStyle(
              color: Colors.black54,
              fontFamily: 'Signatra',
              fontSize: 30,
            ),
          ),
          actions: [
            next
                ? Container()
                : ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black54,
                        fontFamily: 'Varela',
                      ),
                    ),
                  ),
          ],
        ),
        body: next
            ? const SingleChildScrollView()
            : Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: GridView.builder(
                      itemCount: _image.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return index == 0
                            ? Center(
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    !uploading ? chooseImage() : null;
                                  },
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: FileImage(
                                    _image[index - 1],
                                  ),
                                  fit: BoxFit.cover,
                                )),
                              );
                      },
                    ),
                  ),
                  uploading
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'uploading...',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircularProgressIndicator(
                                value: val,
                                valueColor:
                                    const AlwaysStoppedAnimation<Color>(Colors.green),
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
