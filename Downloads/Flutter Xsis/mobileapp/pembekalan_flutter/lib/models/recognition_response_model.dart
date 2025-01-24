import 'package:flutter/material.dart';

class RecognitionResponseModel {
  //aksi
  final String imgPath;
  final String recognizedText;

  RecognitionResponseModel(
      {required this.imgPath, required this.recognizedText});

  @override
  // TODO: implement hashCode
  int get hashCode => imgPath.hashCode ^ recognizedText.hashCode;

  @override
  bool operator ==(covariant RecognitionResponseModel other) {
    if (identical(this, other)) return true;

    return other.imgPath == imgPath && other.recognizedText == recognizedText;
  }
}
