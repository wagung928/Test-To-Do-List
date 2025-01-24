import 'package:pembekalan_flutter/models/info_mahasiswa_model.dart';
import 'package:pembekalan_flutter/utilities/repositories/db_repository.dart';

class InfoMahasiswaViewmodel {
  //method
  InfoMahasiswaViewmodel();
  //insert new data
  Future<int> insertDataMahasiswa(InfoMahasiswaModel model) async {
    return await DbRepository().insertDataMahasiswa(model);
  }

  //Read Data
  Future<List<InfoMahasiswaModel>> readDataMahasiswa() async {
    return await DbRepository().readDataMahasiswa();
  }

  //Update Data Mahasiswa
  Future<int> updateDataMahasiswa(InfoMahasiswaModel model) async {
    return await DbRepository().updateDataMahasiswa(model);
  }

  //Read Data By Id
  Future<InfoMahasiswaModel> readDataMahasiswaById(int id) async {
    return await DbRepository().readDataMahasiswaById(id);
  }

  //Search Data By Keyword
  Future<List<InfoMahasiswaModel>> searchDataMahasiswa(String keyword) async {
    return await DbRepository().searchDataMahasiswa(keyword);
  }

  //Delete Data By Id
  Future<int> deleteDataMahasiswa(InfoMahasiswaModel model) async {
    return await DbRepository().deleteDataMahasiswa(model);
  }
}
