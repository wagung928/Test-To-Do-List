import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';
import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/viewmodels/info_mahasiswa_viewmodel.dart';

class UpdateDataMahasiswaScreen extends StatefulWidget {
  // const UpdateDataMahasiswaScreen({super.key});
  final InfoMahasiswaModel? data;
  UpdateDataMahasiswaScreen({this.data});

  @override
  State<UpdateDataMahasiswaScreen> createState() =>
      _UpdateDataMahasiswaScreenState();
}

class _UpdateDataMahasiswaScreenState extends State<UpdateDataMahasiswaScreen> {
  //penampung nama Controller
  TextEditingController _namaController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _alamatController = new TextEditingController();
  TextEditingController _jurusanController = new TextEditingController();
  String _tanggalLahir = '-';
  File? _image;
  String _fotoPath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //isi nama data yang mau di Edit
    setState(() {
      _namaController.text = widget.data!.nama!;
      _genderController.text = widget.data!.gender!;
      _alamatController.text = widget.data!.alamat!;
      _jurusanController.text = widget.data!.jurusan!;
      _tanggalLahir = widget.data!.tanggal_lahir!;
      _fotoPath = widget.data!.foto_path!;
      _image = File(_fotoPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Mahasiswa'),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GestureDetector(
        // untuk hidden dan show text field
        onTap: () {
          //callback hide
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Input Nama Lengkap'),
                maxLength: 50,
                //controller penampung input nama lengkap
                controller: _namaController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pilih Tanggal Lahir (dd/MM/yyyy) '),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            //aksi pencet tgl
                            pilihTanggalLahir();
                          },
                          icon: Icon(Icons.calendar_month)),
                      Text(
                        '$_tanggalLahir',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              //kembar
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Gender L/P'),
                maxLength: 1,
                controller: _genderController,
              ),
            ),
            Padding(
              //kembar
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Alamat Lengkap'),
                maxLength: 200,
                controller: _alamatController,
              ),
            ),
            Padding(
              //kembar
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                decoration: InputDecoration(hintText: 'Jurusan'),
                maxLength: 30,
                controller: _jurusanController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    getImageFromCamera();
                  },
                  child: _image == null
                      ? Image.asset(
                          'assets/images/logo_xa.png',
                          width: 100,
                          height: 100,
                        )
                      : Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                //validasi input
                validasiInput();
              },
              child: Text(
                'Update Data',
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

  void pilihTanggalLahir() async {
    final DateTime? picker = await showDatePicker(
        context: context,
        firstDate: DateTime(1945),
        lastDate: DateTime.now(),
        initialDate: DateTime.now());
    if (picker != null) {
      setState(() {
        _tanggalLahir = DateFormat('dd/MM/yyyy').format(picker);
      });
    } else {}
  }

  void getImageFromCamera() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _fotoPath = pickedImage.path;

        print('Path Image = ${pickedImage.path}');
      } else {}
    });
  }

  //CRUD SQL Lite
  void validasiInput() {
    if (_namaController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar('Nama Lengkap Harus di isi'));
    } else if (_tanggalLahir.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar('tgl lahir belum di pilih'));
    } else if (_genderController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar('gender belum di isi'));
    } else if (_alamatController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar('alamat belum di isi'));
    } else if (_jurusanController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar('jurusan belum di isi'));
    } else if (_image == null && _fotoPath.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar('Foto Profil belum di pilih'));
    } else {
      //simpan ke DB dan paggil View Model nya
      updateDataMahasiswa();
    }
  }

  void updateDataMahasiswa() async {
    InfoMahasiswaModel updateModel = new InfoMahasiswaModel(
        id: widget.data!.id, //PK untuk keperluan update
        nama: _namaController.text,
        tanggal_lahir: _tanggalLahir,
        gender: _genderController.text,
        alamat: _alamatController.text,
        jurusan: _jurusanController.text,
        foto_path: _fotoPath);
    await InfoMahasiswaViewmodel()
        .updateDataMahasiswa(updateModel)
        .then((value) {
      print('Response Database : $value');
      Navigator.pop(context);
    });
  }
}
