import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';

class LocationServicesScreen extends StatefulWidget {
  const LocationServicesScreen({super.key});

  @override
  State<LocationServicesScreen> createState() => _LocationServicesScreenState();
}

class _LocationServicesScreenState extends State<LocationServicesScreen> {
  String? latitude, longitude, alttude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Services'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.amber[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Latitude : $latitude',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Longitude : $longitude',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Altitude $alttude: ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                //aksi location tampilan
                tampilkanLokasiSaya();
              },
              child: Text(
                'Get My Current Position',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue)),
            )
          ],
        ),
      ),
    );
  }

  void tampilkanLokasiSaya() {
    //method untuk mendapatkan info lokasi
    temukanLokasiSaya().then((value) {
      setState(() {
        //set lokasi
        latitude = value.latitude.toString();
        longitude = value.longitude.toString();
        alttude = value.altitude.toString();
      });
    });
  }

  Future<Position> temukanLokasiSaya() async {
    //
    bool serviceEnabled;
    LocationPermission permission;
    // return apakah location service aktif/tidak
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled) {
      //location sudah aktif
      //apakah permission di allow/tidak oleh user
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied ||
          permission != LocationPermission.deniedForever) {
        //di izinkan oleh user
        //ambil location berdasarkan akurasi high
        return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      } else {
        //tidak di izinkan user
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar('Location Permission Denied'));
        return Future.error('Location Permission Denied');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
          'Location Service Disabled, please turn on location!'));
      return Future.error('Location Service Disabled');
    }
  }
}
