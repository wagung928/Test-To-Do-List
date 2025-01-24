import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //1 DB dengan banyak tabel
  String databaseName = 'info_mahasiswa.db';
  String tableName = 'profil_mahasiswa';

  //init db
  Future<Database> initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), '$databaseName'),
        //versi db default = 1, jika nantinya ada update, maka naikkan angkanya agar ter-replace
        version: 1,
        //operasi yang pertama kali dilakukan saat terkoneksi dengan DB (call DB 1st)
        onCreate: createTable);
  }

//create table hanya dilakukan jika (belum/tidak tersedia)
  void createTable(Database db, int version) async {
    //gunakan methode RAW Query untuk create table
    String syntaxQuery = '''CREATE TABLE "$tableName" (
    "id"	INTEGER,
    "nama"	TEXT,
    "tanggal_lahir"	TEXT,
    "gender"	TEXT,
    "alamat"	TEXT,
    "jurusan"	TEXT,
    "foto_path"	TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
  );''';
    await db.execute(syntaxQuery); //eksekusi create table
  }
}
