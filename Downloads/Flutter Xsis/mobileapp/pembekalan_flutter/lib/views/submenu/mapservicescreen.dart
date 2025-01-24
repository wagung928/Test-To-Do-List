import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pembekalan_flutter/customs/custom_compass_painter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapServiceScreen extends StatefulWidget {
  const MapServiceScreen({super.key});

  State<MapServiceScreen> createState() => _MapServiceScreenState();
}

class _MapServiceScreenState extends State<MapServiceScreen> {
  //penampung cahce maps lokasi saat peta di tampilkan pertama kali
  CameraPosition initPosition = CameraPosition(
      target: LatLng(3.1470667, 101.6175133), zoom: 20); //koordinat IBM PI

  //untuk custom Icon Maps Google
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

  //pembuatan marker location untuk button Go to Map tujuan (harus String Unik)
  static Marker xaMarker = Marker(
      markerId: MarkerId('12345'),
      position: LatLng(-7.762456797474411, 110.39590391187689),
      infoWindow: InfoWindow(
          title: 'Xsis Dev Center Jogja', snippet: 'silahkan klik bio ya'),
      onTap: () async {
        //aksi pindah web chrome use URL
        String url = 'https://www.xsis.co.id/xsis-academy/';

        //tambahin try cath url
        await canLaunchUrl(Uri.parse(url))
            ? await launchUrl(Uri.parse(url),
                mode: LaunchMode.externalApplication)
            : throw 'Could not launch $url';
      });

  //Coordinate untuk perpindahan ke go to Map klik button
  CameraPosition xaCoordinate = CameraPosition(
      target: LatLng(-7.762456797474411, 110.39590391187689), zoom: 20);

  //controller Map Function
  Completer<GoogleMapController> controllerMap = Completer();

  //semua marker yang akan di daftarkan di tampung disini
  List<Marker> markers = <Marker>[];

  //menampung layout compass
  OverlayEntry? overlayEntry;
  @override
  void dispose() {
    super.dispose();
    print('On Dispose/hide .....');

    overlayEntry!.remove();
    print('Remove Compass ...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Google Maps Services',
        ),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.deepOrange,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GoogleMap(
        initialCameraPosition: initPosition,
        mapType: MapType.normal, //setting mode map
        //untuk controller agar di kenali dan berfungsi
        onMapCreated: (GoogleMapController controller) {
          //proses handle aksi pada peta
          controllerMap.complete(controller);
        },
        //penanda marker point
        markers: Set<Marker>.of(markers),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton.extended(
          onPressed: () {
            //aksi button pindah lokasi screen map titik baru
            goToXsisJogja();
          },
          label: Text(
            'Go tp XSIS Jogja',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.school,
            color: Colors.white,
          ),
          backgroundColor: Colors.indigoAccent,
        ),
      ),
      floatingActionButtonLocation:
          //ini jadi ke tengah
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Future<void> goToXsisJogja() async {
    //aksi button perpindahan ke map button klik
    final GoogleMapController controller = await controllerMap.future;
    //memaksa pindah ke posisi yang di klik
    controller.animateCamera(CameraUpdate.newCameraPosition(xaCoordinate));

    setState(() {
      //aksi pindah dengan paksa use marker dan perlu di daftarin
      //list add marker set pertama, dan bisa seterusnya
      //di real app perlu namanya initState() untuk req API
      markers.add(xaMarker);
    });

    //fitur extra, tambahkan kompas
    showCompass(context);
  }

  //fitur Extra tambahan fitur kompas
  void showCompass(BuildContext context) {
    //aksi kompass
    final size = MediaQuery.of(context).size;
    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            top: size.height * 0.6,
            left: size.width * 0.2,
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: size.height * 0.3,
                width: size.width * 0.6,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.center,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: StreamBuilder(
                        stream: FlutterCompass.events,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                                'Error reading heading ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          //tangkap bacaan arah mata angin
                          double? direction = snapshot.data!.heading;

                          if (direction == null) {
                            return const Center(
                              child: Text('Device does not have sensors'),
                            );
                          } else {
                            return SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomPaint(
                                    size: size,
                                    painter:
                                        CustomCompassPainter(angle: direction),
                                  ),
                                  Text(
                                    buildArahMataAngin(direction),
                                    style: TextStyle(
                                        fontSize: 70, color: Colors.grey[700]!),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      '${direction.toStringAsFixed(5)}',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                  ),
                ),
              ),
            )));
    //untuk Tampilkan Kompas
    Overlay.of(context).insert(overlayEntry!);
  }

  String buildArahMataAngin(double direction) {
    //aksi kompas arah mata angin
    if (direction == 0 && direction <= 45 ||
        direction >= 315 && direction <= 360) {
      return 'N'; //Utara
    } else if (direction > 45 && direction <= 135) {
      return 'E'; //Timur
    } else if (direction > 135 && direction < 225) {
      return 'S'; //Selatan
    } else if (direction > 225 && direction <= 315) {
      return 'W'; //Barat
    } else {
      return "-";
    }
  }
}
