import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraGaleryScreen extends StatefulWidget {
  const CameraGaleryScreen({super.key});

  @override
  State<CameraGaleryScreen> createState() => _CameraGaleryScreenState();
}

class _CameraGaleryScreenState extends State<CameraGaleryScreen> {
  //penampung file dari camera
  File? _image;
  //pemanggilan picker
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera & Galery'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: _image == null ? Text('No Image Selected') : Image.file(_image!),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, //atur jarak dalam row
          children: [
            FloatingActionButton(
              onPressed: () {
                //aksi ambil image dari camera to galery
                getImageFromGalery();
              },
              child: Icon(
                Icons.photo_album,
                color: Colors.white,
              ),
              backgroundColor: Colors.redAccent,
              heroTag: null,
            ),
            FloatingActionButton(
                onPressed: () {
                  //aksi ambil image dari camera to galery
                  getImageFromCamera();
                },
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
                backgroundColor: Colors.redAccent,
                heroTag: null)
          ],
        ),
      ),
      //untuk meratakan icon camera dan image sesuai layar use FloatingActionButtonLocation
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

//method onPress getImageFromCamera
  Future getImageFromCamera() async {
    XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        requestFullMetadata: true);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No Image selected from Camera');
      }
    });
  }

  //method onPress getImageFromCamera
  Future getImageFromGalery() async {
    XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        requestFullMetadata: true);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No Image selected from Galery');
      }
    });
  }
}
