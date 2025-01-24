import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_confirmationdialog.dart';
import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/viewmodels/info_mahasiswa_viewmodel.dart';
import 'package:pembekalan_flutter/views/submenu/updatedatamahasiswascreen.dart';

class DetailMahasiswaScreen extends StatefulWidget {
  // const DetailMahasiswaScreen({super.key});
  //untuk handle data yang di kirim dari pemanggilnya
  final InfoMahasiswaModel? data;

  DetailMahasiswaScreen({this.data});

  @override
  State<DetailMahasiswaScreen> createState() => _DetailMahasiswaScreenState();
}

class _DetailMahasiswaScreenState extends State<DetailMahasiswaScreen> {
  //perlu penampung untuk di tampilkan apa saja
  File? image;
  String? nama, tanggal_lahir, gender, alamat, jurusan;
  int? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // //manggil data dari InfoMahasiswaModel
    setInitValue(widget.data!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Mahasiswa'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.deepOrangeAccent,
        iconTheme: IconThemeData(color: Colors.white), //icon back
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: image == null
                  ? Image.asset(
                      'assets/images/logo_xa.png',
                      width: 250,
                      height: 250,
                    )
                  : Image.file(
                      image!,
                      width: 250,
                      height: 250,
                    ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Row(
                  children: [
                    Text(
                      'Nama Lengkap : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$nama',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Row(
                  children: [
                    Text(
                      'Tanggal Lahir : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$tanggal_lahir',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Row(
                  children: [
                    Text(
                      'Gender : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$gender',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Row(
                  children: [
                    Text(
                      'Alamat : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$alamat',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Row(
                  children: [
                    Text(
                      'Jurusan : ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$jurusan',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
              ),
              //untuk button edit dan delete
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          //aksi Edit
                          pindahKeUpdateDataMahasiswaScreen(widget.data!);
                        },
                        icon: Icon(Icons.edit)),
                    SizedBox(
                      width: 50,
                    ),
                    IconButton(
                        onPressed: () {
                          //aksi Delete
                          konfirmasiDelete(widget.data!);
                        },
                        icon: Icon(Icons.delete_forever)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void pindahKeUpdateDataMahasiswaScreen(InfoMahasiswaModel dataModel) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdateDataMahasiswaScreen(data: dataModel))).then((value) {
      setState(() {
        //refresh data update tampilan detail
        readUlangData();
      });
    });
  }

  void readUlangData() async {
    await InfoMahasiswaViewmodel().readDataMahasiswaById(id!).then((value) {
      print('Response Read Ulang = $value');
      setState(() {
        //aksi
        setInitValue(value);
      });
    });
  }

  void setInitValue(InfoMahasiswaModel model) {
    //manggil data dari InfoMahasiswaModel di jadikan method dan di panggil di initState bagian Atas
    image = File(model.foto_path!);
    nama = model.nama;
    tanggal_lahir = model.tanggal_lahir;
    gender = model.gender;
    alamat = model.alamat;
    jurusan = model.jurusan;
    id = model.id;
  }

  void konfirmasiDelete(InfoMahasiswaModel dataModel) async {
    //aksi delete by Id
    var confirmationDialog = CustomConfirmationdialog(
      title: 'Hapus Data',
      message: 'Yakin ingin menghapus data ?',
      yes: 'Ya',
      no: 'Tidak',
      pressYes: () {
        //aksi
        hapusDataMahasiswa(dataModel);
        Navigator.of(context).pop();
      },
      pressNo: () {
        //aksi
        Navigator.of(context).pop();
      },
    );
    showDialog(context: context, builder: (_) => confirmationDialog);
  }

  void hapusDataMahasiswa(InfoMahasiswaModel dataModel) async {
    //aksi kirim data Id
    await InfoMahasiswaViewmodel().deleteDataMahasiswa(dataModel).then((value) {
      //handle
      setState(() {
        print('Jumlah Record yang terkena = $value');

        //kembali ke List Mahasiswa Screen
        Navigator.of(context).pop();
      });
    });
  }
}
