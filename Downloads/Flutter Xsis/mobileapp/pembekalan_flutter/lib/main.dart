import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pembekalan_flutter/translations/codegen_loader.g.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';
import 'package:pembekalan_flutter/views/dashboardscreen.dart';
import 'package:pembekalan_flutter/views/loginscreen.dart';
import 'package:pembekalan_flutter/views/registerscreen.dart';

import 'package:pembekalan_flutter/views/splashscreen.dart';
import 'package:pembekalan_flutter/views/submenu/cameragaleryscreen.dart';
import 'package:pembekalan_flutter/views/submenu/detail/detailimagescreen.dart';
import 'package:pembekalan_flutter/views/submenu/detail/detailmahasiswascreen.dart';
import 'package:pembekalan_flutter/views/submenu/imagingsliderscreen.dart';
import 'package:pembekalan_flutter/views/submenu/inputdatamahasiswascreen.dart';
import 'package:pembekalan_flutter/views/submenu/listmahasiswascreen.dart';
import 'package:pembekalan_flutter/views/submenu/locationservicesscreen.dart';
import 'package:pembekalan_flutter/views/submenu/mapservicescreen.dart';
import 'package:pembekalan_flutter/views/submenu/ocrscreen.dart';
import 'package:pembekalan_flutter/views/submenu/parsingdata.dart';
import 'package:pembekalan_flutter/views/submenu/updatedatamahasiswascreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // runApp(const MainApp());
  runApp(
    EasyLocalization(
        //syntax translate
        // run this command on terminal to generate localizations assets
        // to add new text, please use i18n manager (open source tools)
        // flutter pub run easy_localization:generate -S "assets/translation" -O "lib/translations"
        // flutter pub run easy_localization:generate -S "assets/translation" -O "lib/translations" -o "locale_keys.g.dart" -f keys

        //menyetting bahasa apa saja
        supportedLocales: [Locale('en'), Locale('id')],
        path:
            'assets/translation', // <-- change the path of the translation files
        startLocale: Locale(
            'id'), //default local language (https://www.npmjs.com/package/i18n-iso-countries)
        fallbackLocale: Locale('id'), //local yang tidak di daftarkan
        assetLoader: CodegenLoader(),
        // assetLoader: CodegennLoader(),
        child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //lock orientasi layar menjadi potrait up
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      //untuk menghilangan debug tampilan awal
      debugShowCheckedModeBanner: false,
      title: 'Pembekalan Flutter 2025 yooo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashScreen(),
      routes: {
        Routes.splashscreen: (context) => SplashScreen(),
        Routes.loginscreen: (context) => Loginscreen(),
        Routes.registerscreen: (context) => RegisterScreen(),
        Routes.dasboardscreen: (context) => DashboardScreen(),
        Routes.parsingdatascreen: (context) => ParsingDataScreen(),
        Routes.ImagingSliderScreen: (context) => ImagingSliderScreen(),
        Routes.DetailImageScreen: (context) => DetailImageScreen(),
        Routes.CameraGaleryScreen: (context) => CameraGaleryScreen(),
        Routes.ListMahasiswaScreen: (context) => ListMahasiswaScreen(),
        Routes.InputDataMahasiswaScreen: (context) =>
            InputDataMahasiswaScreen(),
        Routes.DetailMahasiswaScreen: (context) => DetailMahasiswaScreen(),
        Routes.UpdateDataMahasiswaScreen: (context) =>
            UpdateDataMahasiswaScreen(),
        Routes.LocationServicesScreen: (context) => LocationServicesScreen(),
        Routes.MapServiceScreen: (context) => MapServiceScreen(),
        Routes.OCRScreen: (context) => OCRScreen(),
      },
    );
  }
}
