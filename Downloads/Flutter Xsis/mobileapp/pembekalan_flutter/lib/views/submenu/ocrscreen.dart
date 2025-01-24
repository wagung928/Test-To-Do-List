import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pembekalan_flutter/customs/custom_image_picker_alert.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';
import 'package:pembekalan_flutter/models/recognition_response_model.dart';
import 'package:pembekalan_flutter/utilities/recognizer/mlkit_text_recognizer.dart';
import 'package:pembekalan_flutter/utilities/recognizer/text_recognizer.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  //penampung
  late ImagePicker _picker;
  late ITextRecognizer _recognizer; //bentuk utilities
  RecognitionResponseModel? _response; //bentuk model

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _picker = ImagePicker();
    _recognizer = MLKitTextRecognizer();
    // _recognizer = TesseractTextRecognizer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
  }

  void processImage(String _imgPath) async {
    final recognizedText = await _recognizer.processImage(_imgPath);
    setState(() {
      _response = RecognitionResponseModel(
          imgPath: _imgPath, recognizedText: recognizedText);
    });
  }

  Future<String?> obtainImage(ImageSource _source) async {
    final file = await _picker.pickImage(source: _source);
    return file?.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OCR Screen'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.deepPurpleAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: _response == null
            ? Text('Pilih Image terlebih dahulu')
            : ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(File(_response!.imgPath)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'Recognized Text',
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                            IconButton(
                                onPressed: () {
                                  //aksi copy
                                  Clipboard.setData(ClipboardData(
                                      text: _response!.recognizedText));

                                  //convert jadi text
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackBar(
                                          'Text Copied to Clipboard'));
                                },
                                icon: Icon(Icons.copy)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _response!.recognizedText,
                          style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //aksi button dialog pilihan
          showDialog(
              context: context,
              //cara manggil class di file lain use builder
              builder: (context) => customImagePickDialog(
                    onCameraPressed: () async {
                      //aksi on camera press
                      final _imgPath = await obtainImage(ImageSource.camera);
                      if (_imgPath == null) return;
                      Navigator.of(context).pop();
                      processImage(_imgPath!);
                    },
                    onGaleryPressed: () async {
                      //aksi on galery press
                      final _imgPath = await obtainImage(ImageSource.gallery);
                      if (_imgPath == null) return;
                      Navigator.of(context).pop();
                      processImage(_imgPath!);
                    },
                  ));
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
