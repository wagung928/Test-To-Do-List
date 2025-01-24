import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_confirmationdialog.dart';
import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';
import 'package:pembekalan_flutter/viewmodels/info_mahasiswa_viewmodel.dart';
import 'package:pembekalan_flutter/views/submenu/detail/detailmahasiswascreen.dart';
import 'package:pembekalan_flutter/views/submenu/updatedatamahasiswascreen.dart';

class ListMahasiswaScreen extends StatefulWidget {
  const ListMahasiswaScreen({super.key});

  @override
  State<ListMahasiswaScreen> createState() => _ListMahasiswaScreenState();
}

class _ListMahasiswaScreenState extends State<ListMahasiswaScreen> {
  //penampung search string
  TextEditingController _keywordPencarian = new TextEditingController();
  // penampung list data mahasiswa
  List<InfoMahasiswaModel> _listMahasiswa = [];

  //langsung menampilkan data yang sudah ada

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //tampilkan seluruh record dari table
    tampilkanListDataMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // untuk hidden dan show text field
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Database Mahasiswa'),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          backgroundColor: Colors.green,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'List Mahasiswa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Keyword Pencarian',
                          suffixIcon: IconButton(
                              onPressed: () {
                                //aksi search di klik
                                cariDataMahasiswa();
                              },
                              icon: Icon(Icons.search))),
                      controller:
                          _keywordPencarian, //penampung controller search string
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: _listMahasiswa.length == 0
                  ? Text('Data Tidak Ditemukan')
                  : ListView.builder(
                      itemCount: _listMahasiswa.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              //aksi
                              //pindah ke Screen Detail Mahasiswa
                              //ambil model info mahasiswa
                              InfoMahasiswaModel dataModel =
                                  _listMahasiswa[index];
                              pindahKeDetailMahasiswaScreen(dataModel);
                            },
                            child: Card(
                              color: index % 2 == 0
                                  ? Colors.white38
                                  : Colors.lightGreenAccent,
                              margin: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: Image.file(
                                        File(_listMahasiswa[index].foto_path!),
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _listMahasiswa[index].nama!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _listMahasiswa[index].jurusan!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  //edit data
                                                  InfoMahasiswaModel dataModel =
                                                      _listMahasiswa[index];
                                                  pindahKeUpdateDataMahasiswaScreen(
                                                      dataModel);
                                                },
                                                icon: Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {
                                                  //delete data
                                                  InfoMahasiswaModel dataModel =
                                                      _listMahasiswa[index];
                                                  konfirmasiDelete(dataModel);
                                                },
                                                icon:
                                                    Icon(Icons.delete_forever))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //pindah ke screen input data Mahasiswa (dan harus bisa callback teknik tambahan)
            Navigator.pushNamed(context, Routes.InputDataMahasiswaScreen)
                .then((value) {
              setState(() {
                //aksi saat terjadi callback saat sudah menambahkan input mahasiswa
                tampilkanListDataMahasiswa();
              });
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          tooltip: 'Tambah Data Mahasiswa',
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

//hasil dari callback input data mahasiswa dan di tampilkan
  void tampilkanListDataMahasiswa() async {
    await InfoMahasiswaViewmodel().readDataMahasiswa().then((value) {
      setState(() {
        //tampilkan list mahasiswa yang sudah di input
        print('Jumlah Record yang di temukan ${value.length}');
        //tampungan list mahasiswa
        _listMahasiswa = value;
      });
    });
  }

//hasil klik ke detail mahasiswa screen dari file DetailMahasiswaScreen
  void pindahKeDetailMahasiswaScreen(InfoMahasiswaModel dataModel) async {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailMahasiswaScreen(data: dataModel)))
        .then((value) {
      //aksi
      setState(() {
        //refresh ulang
        tampilkanListDataMahasiswa();
      });
    });
  }

  void pindahKeUpdateDataMahasiswaScreen(InfoMahasiswaModel dataModel) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdateDataMahasiswaScreen(data: dataModel))).then((value) {
      //aksi
      setState(() {
        //refresh ulang
        tampilkanListDataMahasiswa();
      });
    });
  }

  void cariDataMahasiswa() async {
    //Search Klik Fungsi
    //selama keywordnya ga kosong tetap cari
    if (_keywordPencarian.text.isEmpty) {
      //tampilkan ulang seluruh list data
      tampilkanListDataMahasiswa();
    } else {
      //cari berdasarkan keyword yang di input
      String keyword = _keywordPencarian.text; //penampung
      await InfoMahasiswaViewmodel().searchDataMahasiswa(keyword).then((value) {
        //aksi
        setState(() {
          print('Hasil Pencarian = ${value.length}');
          //update hasil search list data mahasiswanya
          _listMahasiswa = value;
        });
      });
    }
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

        //refresh list
        tampilkanListDataMahasiswa();
      });
    });
  }
}
