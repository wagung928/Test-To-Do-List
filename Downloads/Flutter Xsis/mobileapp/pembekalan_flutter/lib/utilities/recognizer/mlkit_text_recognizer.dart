import 'dart:io';
import 'dart:developer';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pembekalan_flutter/utilities/recognizer/text_recognizer.dart';

class MLKitTextRecognizer extends ITextRecognizer {
  //aksi
  late TextRecognizer recognizer;

  MLKitTextRecognizer() {
    recognizer = TextRecognizer();
  }

  @override
  Future<String> processImage(String imgPath) async {
    final image = InputImage.fromFile(File(imgPath));
    final recognized = await recognizer.processImage(image);

    return recognized.text;
  }

  //untuk deteksi all in semua block yang terfoto
  //https://developers.google.com/ml-kit/vision/text-recognition/v2
  Future<void> processImageInBlock(InputImage image) async {
    final recognized = await recognizer.processImage(image);
    final blocks = recognized.blocks;

    for (int i = 0; i < blocks.length; i++) {
      final e = blocks[i];
      log('block number $i'); //print
      log(e.text);
    }
  }

  //untuk close method recognizer
  void dispose() {
    recognizer.close();
  }
}
