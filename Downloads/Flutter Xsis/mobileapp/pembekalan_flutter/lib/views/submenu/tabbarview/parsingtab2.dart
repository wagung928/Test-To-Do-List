import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class Parsingtab2 extends StatefulWidget {
  const Parsingtab2({super.key});

  @override
  State<Parsingtab2> createState() => _Parsingtab2State();
}

class _Parsingtab2State extends State<Parsingtab2>
    with AutomaticKeepAliveClientMixin {
  //penampung Json
  int responseCode = 0;
  List? dataUsers;

  //progress dialog
  ProgressDialog? loading;

  @override
  Widget build(BuildContext context) {
    //ini loading nya
    loading = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
    loading!.style(
        message: 'Mohon tunggu...',
        progressWidget: CircularProgressIndicator(),
        borderRadius: 10,
        elevation: 10,
        insetAnimCurve: Curves.easeInOut);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              //panggil API
              get10Users();
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black12)),
            child: Text(
              'Get 10 Users',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('HTTP Response Code = $responseCode'),
          Expanded(
            child: ListView.builder(
              itemCount: dataUsers == null ? 0 : dataUsers!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: InkWell(
                    child: Card(
                      color:
                          index % 2 == 0 ? Colors.white24 : Colors.amberAccent,
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name : ${dataUsers![index]['name']} (${dataUsers![index]['username']})',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Email : ${dataUsers![index]['email']}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Address : ${dataUsers![index]['address']['street']},${dataUsers![index]['address']['suite']},${dataUsers![index]['address']['city']},${dataUsers![index]['address']['zipcode']}',
                            style: TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    //dari InkWell link
                    onTap: () {
                      //jika di klik memunculkan info lat long dalam bentuk snackbar
                      String lat = dataUsers![index]['address']['geo']['lat'];
                      String lng = dataUsers![index]['address']['geo']['lng'];
                      String username = dataUsers![index]['username'];

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          '$username ($lat,$lng)',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.blueAccent,
                      ));
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  //method get10Users function
  Future<String?> get10Users() async {
    //tampilkan loading dengan tutup
    await loading!.show();

    final String urlAPI = "https://jsonplaceholder.typicode.com/users";
    var request = await http.get(Uri.parse(urlAPI), headers: {
      //headers standart
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json'
    });
    //menangkap response
    var response = request.body;
    print('Hasil baca API = $response');
    setState(() {
      responseCode = request.statusCode;

      //konversi dari response API => format JSON Flutter
      //supaya bisa diparsing Datanya
      dataUsers = json.decode(response); //penampung Json string use decode

      //close loading setelah selesai jadi json
      loading!.hide();
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
