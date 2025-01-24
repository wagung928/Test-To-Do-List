import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_confirmationdialog.dart';
import 'package:pembekalan_flutter/customs/custom_language_chooser.dart';
import 'package:pembekalan_flutter/translations/locale_keys.g.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';
import 'package:pembekalan_flutter/utilities/sharedpreferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //variabel setting untuk mengambil username dan token
  String username = '-';
  String token = '-';

  @override
  void initState() {
    super.initState();
    // ambil username dari sharedpreferences
    SharedPreferencesHelper.readUsername().then((value) {
      setState(() {
        username = value;
      });
    });
    // ambil token dari sharedpreferences
    SharedPreferencesHelper.readToken().then((value) {
      setState(() {
        token = value;
      });
    });
  }

  Widget build(BuildContext context) {
    //template standar app use Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.dashboard_menu.tr()),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blueAccent,
        centerTitle: true, //ini untuk center Dashboard
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      //icon menu strip 3 menu bar use Drawer
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              // posisi diatas untuk dashboard garis 3 geser
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blueAccent),
                    child: Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //use ClipRRect untuk manggil url gambar di link
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                "https://reqres.in/img/faces/9-image.jpg",
                                height: 80,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              username,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              token,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ))),
                //user Card untuk di bawah username
                Card(
                  color: Colors.amberAccent,
                  //ngatur dalam komponennya use margin
                  margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(LocaleKeys.dashboard_menu.tr()),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                    //menambah fungsi action ketika di tekan
                    onTap: () {
                      //action di tekan
                    },
                  ),
                ),
                Card(
                  color: Colors.amberAccent,
                  //ngatur dalam komponennya use margin
                  margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: ListTile(
                    leading: Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                    ),
                    title: Text(LocaleKeys.administrator.tr()),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 16),
                    //menambah fungsi action ketika di tekan
                    onTap: () {
                      //action di tekan
                    },
                  ),
                ),
                Card(
                    color: Colors.amberAccent,
                    //ngatur dalam komponennya use margin
                    margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                    // use ExpansionTile untuk expan seperti dropdown
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ExpansionTile(
                        title: Text(
                          LocaleKeys.settings.tr(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        //untuk animasi use leading
                        leading: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        //untuk panah sebelah settings jadi putih dan animasi
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        textColor: Colors.white,
                        backgroundColor: Colors.grey,
                        collapsedBackgroundColor: Colors.amberAccent,
                        children: [
                          InkWell(
                              onTap: () {
                                pilihBahasa();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    LocaleKeys.language_setting.tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              )),
                          // use InkWell untuk menambahkan condition
                          InkWell(
                            onTap: () {
                              //aksi ketika di tekan
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                ),
                                Text(
                                  LocaleKeys.theme_settings.tr(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                              ),
                              Text(
                                LocaleKeys.tnc.tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            )),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: TextButton(
                onPressed: () {
                  //aksi jika button di tekan
                  logoutConfirmation(context);
                },
                child: Text(
                  LocaleKeys.logout.tr(),
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    // user background color logout use WidgetStateProperty
                    backgroundColor: WidgetStateProperty.all(Colors.redAccent)),
              ),
            )
          ],
        ),
      ),
      body: DashboardScreenLayout(),
    );
  }

//untuk fungsi onTap logout dan login
  logoutConfirmation(BuildContext _context) {
    //tinggal maggil dart dari CustomConfirmationdialog yang sudah di buatkan
    var confirmationDialog = CustomConfirmationdialog(
      title: 'Confirmation',
      message: 'Apakah anda yakin ingin logout?',
      yes: 'Ya',
      no: 'Tidak',
      pressYes: () {
        //1. jadi logout, mengganti flag isLogin => logout (false)
        SharedPreferencesHelper.saveIsLogin(false);

        //2. hilangkan si dialog pop up confirm nya
        Navigator.of(_context).pop();

        //3. pindah ke login Screen, tapi semua screen sebelumnya di hapus dari stack
        Navigator.pushReplacementNamed(_context, Routes.loginscreen);
      },
      pressNo: () {
        //tidak jadi logout
        Navigator.of(_context).pop();
      },
    );
    showDialog(context: _context, builder: (_) => confirmationDialog);
  }

  void pilihBahasa() async {
    showDialog(
        context: context,
        builder: (context) => customLanguageChooser(
              onID: () async {
                //Bahasa Indonesia
                Navigator.of(context).pop();
                context.setLocale(Locale(
                    'id')); // https://www.npmjs.com/package/i18n-iso-countries
                print('Bahasa dipilih : ${context.locale.toString()}');
              },
              onEN: () async {
                //Bahasa Inggris
                Navigator.of(context).pop();
                context.setLocale(Locale(
                    'en')); // https://www.npmjs.com/package/i18n-iso-countries
                print('Bahasa dipilih : ${context.locale.toString()}');
              },
            ));
  }
} //close code

//setting Layout Utama Dasboard untuk fungsinya
class DashboardScreenLayout extends StatefulWidget {
  const DashboardScreenLayout({super.key});

  @override
  State<DashboardScreenLayout> createState() => _DashboardScreenLayoutState();
}

class _DashboardScreenLayoutState extends State<DashboardScreenLayout> {
  @override
  Widget build(BuildContext context) {
    //properti nambahin panel pada layout dashboard utama
    return GridView.count(
      crossAxisCount: 2,
      // use chidren untuk mengisi kontent di dalamnya
      children: [
        Card(
          color: Colors.orangeAccent,
          //mau pindah menu use InkWell || ngelink menu lain use onTap(){//aksi}
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.archive,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Parsing Data API',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: () {
              //pindah ke screen parsing
              Navigator.pushNamed(context, Routes.parsingdatascreen);
            },
          ),
        ),
        Card(
          color: Colors.green,
          //mau pindah menu use InkWell || ngelink menu lain use onTap(){//aksi}
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Imaging & Slider',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: () {
              //pindah ke screen Imaging
              Navigator.pushNamed(context, Routes.ImagingSliderScreen);
            },
          ),
        ),
        Card(
          color: Colors.pinkAccent,
          //mau pindah menu use InkWell || ngelink menu lain use onTap(){//aksi}
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Camera & Galery',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: () {
              //pindah ke screen parsing
              Navigator.pushNamed(context, Routes.CameraGaleryScreen);
            },
          ),
        ),
        Card(
          color: Colors.blueAccent,
          //mau pindah menu use InkWell || ngelink menu lain use onTap(){//aksi}
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.document_scanner,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'SQfLite & Database',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: () {
              //pindah ke screen SQfLite
              Navigator.pushNamed(context, Routes.ListMahasiswaScreen);
            },
          ),
        ),
        Card(
          color: Colors.grey,
          //mau pindah menu use InkWell || ngelink menu lain use onTap(){//aksi}
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Location Services',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: () {
              //pindah ke screen Location
              Navigator.pushNamed(context, Routes.LocationServicesScreen);
            },
          ),
        ),
        Card(
          color: Colors.blueGrey,
          //mau pindah menu use InkWell || ngelink menu lain use onTap(){//aksi}
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Map Services',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: () {
              //pindah ke screen Map
              Navigator.pushNamed(context, Routes.MapServiceScreen);
            },
          ),
        ),
        Card(
          color: Colors.purpleAccent,
          //mau pindah menu use InkWell || ngelink menu lain use onTap(){//aksi}
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.scanner,
                  color: Colors.white,
                  size: 100,
                ),
                Text(
                  'Text Recognition\n(OCR)',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            onTap: () {
              //pindah ke screen Text Recognition
              Navigator.pushNamed(context, Routes.OCRScreen);
            },
          ),
        ),
      ],
    );
  }
}
