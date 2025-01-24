import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class DetailImageScreen extends StatelessWidget {
  // const DetailImageScreen({super.key});
  final String? urlImage;

  DetailImageScreen({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Image (Pinch to Zoom)'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.amberAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PinchZoom(
            child: Image.network(urlImage!),
            maxScale: 3,
            zoomEnabled: true,
          )
        ],
      ),
    );
  }
}
