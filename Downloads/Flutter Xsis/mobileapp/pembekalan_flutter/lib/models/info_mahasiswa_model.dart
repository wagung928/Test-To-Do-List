import 'dart:convert';

import 'package:flutter/widgets.dart';

class InfoMahasiswaModel {
  int? id;
  String? nama;
  String? tanggal_lahir;
  String? gender;
  String? alamat;
  String? jurusan;
  String? foto_path;

  InfoMahasiswaModel({
    this.id,
    this.nama,
    this.tanggal_lahir,
    this.gender,
    this.alamat,
    this.jurusan,
    this.foto_path,
  });

//extention Dart Getter Setter

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'tanggal_lahir': tanggal_lahir,
      'gender': gender,
      'alamat': alamat,
      'jurusan': jurusan,
      'foto_path': foto_path,
    };
  }

  factory InfoMahasiswaModel.fromMap(Map<String, dynamic> map) {
    return InfoMahasiswaModel(
      id: map['id']?.toInt(),
      nama: map['nama'],
      tanggal_lahir: map['tanggal_lahir'],
      gender: map['gender'],
      alamat: map['alamat'],
      jurusan: map['jurusan'],
      foto_path: map['foto_path'],
    );
  }
}
