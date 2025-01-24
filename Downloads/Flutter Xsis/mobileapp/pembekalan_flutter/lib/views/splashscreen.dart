import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/utilities/sharedpreferences.dart';
import 'package:pembekalan_flutter/views/dashboardscreen.dart';
import 'package:pembekalan_flutter/views/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_xa.png",
              width: 150.0, //bisa pakai koma
              height: 150,
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 20, 5, 20)),
            Text(
              'Pembekalan Flutter 2025',
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BiomeRegular'),
            ),
            SizedBox(
              // transparan mengganti fungsi padding
              height: 5,
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Versi ',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  TextSpan(
                    text: '1.0.0 Beta',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    startSplashScreenDelay();
  }

  startSplashScreenDelay() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, callback);
  }

  callback() {
    // proses berikutnya
    //cek login?
    SharedPreferencesHelper.readIsLogin().then((isLogin) {
      if (isLogin) {
        //sudah login?
        //pindah ke dashboardscreen
        pindahkeDashboardSreen();
      } else {
        pindahKeLoginScreen();
      }
      // pindahKeLoginScreen();
    });
  }

  pindahKeLoginScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return Loginscreen();
    }));
  }

  pindahkeDashboardSreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return DashboardScreen();
    }));
  }
}
