import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_alertdialog.dart';
import 'package:pembekalan_flutter/utilities/sharedpreferences.dart';
import 'package:pembekalan_flutter/viewmodels/login_user_viewmodel.dart';
import 'package:pembekalan_flutter/views/dashboardscreen.dart';
import 'package:pembekalan_flutter/views/registerscreen.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String username = '';
  String password = '';
  bool isRememberMe = false;

  final TextEditingController _controllerUsername = new TextEditingController();
  final TextEditingController _controllerPassword = new TextEditingController();

  ProgressDialog? loading;

  // fungsi Check is Remember Me agar username dan password sugest nya tersave saat di ceklis
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //proses periksa flag is RememberMe
    SharedPreferencesHelper.readIsRemember().then((value) {
      if (value) {
        //autofil untuk username dan password
        SharedPreferencesHelper.readUsername().then((usr) {
          //untuk mengupdate use setState
          setState(() {
            _controllerUsername.text = usr;
            username = usr;
          });
        });
        //autofil untuk username dan password
        SharedPreferencesHelper.readUsername().then((pwd) {
          setState(() {
            //untuk mengupdate
            _controllerPassword.text = pwd;
            password = pwd;
          });
        });
        //action handler untuk dinamis setState tang tersave sudah tercentang
        setState(() {
          isRememberMe = true; // agar tidak kosong makai !
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //untuk mengetahui ukuran layar widh dan height nya
    Size size = MediaQuery.of(context).size;

    //init loading
    loading = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
    loading!.style(
        message: ' Login, Silahkan Tunggu ...',
        progressWidget: CircularProgressIndicator(),
        borderRadius: 10,
        elevation: 10,
        insetAnimCurve: Curves.easeInOut);

    return Container(
      color: Colors.grey,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: GestureDetector(
          //untuk tambahan sebagai hide keyboard
          behavior: HitTestBehavior.opaque, // Tangkap klik di area kosong
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/logo_xa.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Login Form',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: _controllerUsername,
                      onChanged: (value) {
                        //set value ke variabel
                        username = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Input Username',
                          hintStyle: TextStyle(color: Colors.grey),
                          border:
                              OutlineInputBorder()), // buat yang kotak input
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: _controllerPassword,
                      onChanged: (value) {
                        //set value ke variabel
                        password = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Input Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder()),
                      // buat yang kotak input
                      obscureText: true, //untuk hidden password
                    ),
                  ),
                  Padding(
                    //untuk Remember Me
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 10),
                    child: CheckboxListTile(
                      value: isRememberMe,
                      onChanged: (newValue) {
                        //action handler untuk dinamis setState
                        setState(() {
                          isRememberMe = newValue!; // agar tidak kosong makai !
                        });
                      },
                      title: Text('Remember Me'),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  // untuk isi inputan text (TextField)
                  TextButton(
                    onPressed: () {
                      //aksi jika tombol login ditekan
                      //untuk menghilangkan keyboard FocusScope
                      FocusScope.of(context).unfocus();
                      validasiLogin();
                    },
                    child: Text('Login Now!'),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.black12),
                        overlayColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.focused)) {
                              return Colors.lightBlue;
                            }
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.blueAccent;
                            }
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black12;
                            }
                            return Colors.grey;
                          },
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Untuk Link text biru
                  InkWell(
                    child: Text(
                      'New Member? Register Now!',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      //pindah Register screen
                      pindahRegisterScreen();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validasiLogin() {
    //sudah input username atau belum
    if (_controllerUsername.value.text.length == 0 || username.length == 0) {
      showAlert(context, 'Warning', 'Anda belum mengisi username!');
    } else if (_controllerPassword.value.text.length == 0 ||
        password.length == 0) {
      showAlert(context, 'Warning', 'Anda belum mengisi password!');
    } else {
      //sudah valid
      //simpan data secara offline (belum konek API)
      // saveDataOffline(context, _controllerUsername.value.text,
      //     _controllerPassword.value.text, isRememberMe);
      loginUser(context, _controllerUsername.text, _controllerPassword.text,
          isRememberMe);
    }
  }

//panggilan dari custom alert dialog
  showAlert(BuildContext _context, String _title, String _message) {
    var alertDialog =
        CustomAlertDialog(title: _title, message: _message, action_text: "OK");
    showDialog(context: _context, builder: (_) => alertDialog);
  }

  pindahRegisterScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return RegisterScreen();
    }));
  }

//untuk login save data offline
  saveDataOffline(BuildContext _context, String _username, String _password,
      bool _isRememberMe, String token) {
    //cara simpan data local
    SharedPreferencesHelper.saveUsername(_username);
    SharedPreferencesHelper.savePassword(_password);
    SharedPreferencesHelper.saveIsRemember(_isRememberMe);
    SharedPreferencesHelper.saveToken(token);

    //flag login = true
    SharedPreferencesHelper.saveIsLogin(true);
  }

  //save data local termasuk token generate
  void loginUser(BuildContext _context, String email, String password,
      bool isRememberMe) async {
    //login tampilan
    await loading!.show();

    //username = eve.holt@reqres.in
    //password = cityslicka
    LoginUserViewmodel().postDataToAPI(_context, email, password).then((value) {
      //tutup loading
      loading!.hide().whenComplete(() {
        //ke DashboardScreen
        Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (_) {
          return DashboardScreen();
        }));
      });

      //perubahan
      setState(() {
        if (value != null) {
          //get token
          String token = value.token;

          saveDataOffline(_context, email, password, isRememberMe, token);
        }
      });
    });
  }
} // close code
