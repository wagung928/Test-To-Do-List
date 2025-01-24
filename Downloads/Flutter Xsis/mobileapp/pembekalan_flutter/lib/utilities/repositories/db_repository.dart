import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/utilities/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DbRepository {
  //CRUD
  DatabaseHelper databaseHelper = new DatabaseHelper();

  //insert data mahasiswa
  Future<int> insertDataMahasiswa(InfoMahasiswaModel model) async {
    final Database db = await databaseHelper.initDatabase();

    final result = await db.insert(databaseHelper.tableName, model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return result;
  }

  //Read Data mahasiswa (ALL) function untuk di panggil
  Future<List<InfoMahasiswaModel>> readDataMahasiswa() async {
    final Database db = await databaseHelper.initDatabase();

    final List<Map<String, dynamic>> datas =
        await db.query(databaseHelper.tableName);
    List<InfoMahasiswaModel> result = List.generate(datas.length, (index) {
      return InfoMahasiswaModel.fromMap(datas[index]);
    });
    return result;
  }

  //Update Data Mahasiswa per Id
  Future<int> updateDataMahasiswa(InfoMahasiswaModel model) async {
    final Database db = await databaseHelper.initDatabase();
    //ini untuk update data nya
    final result = await db.update(databaseHelper.tableName, model.toMap(),
        //parameter kondisi
        where: 'id = ?',
        //value
        whereArgs: [model.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  //Read Data mahasiswa by ID function untuk di panggil
  Future<InfoMahasiswaModel> readDataMahasiswaById(int id) async {
    final Database db = await databaseHelper.initDatabase();

    final List<Map<String, dynamic>> datas = await db
        .query(databaseHelper.tableName, where: 'id = ?', whereArgs: [id]);
    List<InfoMahasiswaModel> result = List.generate(datas.length, (index) {
      return InfoMahasiswaModel.fromMap(datas[index]);
    });
    return result.elementAt(0);
  }

  //Search Data mahasiswa (by keyword = nama)
  Future<List<InfoMahasiswaModel>> searchDataMahasiswa(String keyword) async {
    final Database db = await databaseHelper.initDatabase();

    //row Query
    String rawQuery =
        'SELECT * FROM ${databaseHelper.tableName} WHERE nama LIKE "%$keyword%"';

    final List<Map<String, dynamic>> datas = await db.rawQuery(rawQuery);

    final result = List.generate(datas.length, (index) {
      //konversi
      return InfoMahasiswaModel.fromMap(datas[index]);
    });
    return result;
  }

  //Delete Data Mahasiswa per Id
  Future<int> deleteDataMahasiswa(InfoMahasiswaModel model) async {
    final Database db = await databaseHelper.initDatabase();
    //pecahkan id dari model
    print('ID yang di get dari model = ${model.id}');
    //ini untuk update data nya
    final result = await db.delete(databaseHelper.tableName,
        //parameter kondisi
        where: 'id = ?',
        //value
        whereArgs: [model.id]);
    return result;
  }
}
