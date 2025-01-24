import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  //key value
  //https://pub.dev/packages/shared_preferences/example
  SharedPreferencesHelper();

  //panggil SharedPreferences
  static Future<SharedPreferences> get sharedpreferences =>
      SharedPreferences.getInstance();

  //key
  static final String KEY_USERNAME = 'KEY_USERNAME';
  static final String KEY_PASSWORD = 'KEY_PASSWORD';
  static final String KEY_ISREMEMBER = 'KEY_ISREMEMBER';
  static final String KEY_ISLOGIN = 'KEY_ISLOGIN';
  static final String KEY_TOKEN = 'KEY_TOKEN';

//METHOD getter and setter untuk data

//simpan username
  static Future saveUsername(String username) async {
    final preference = await sharedpreferences;
    return preference.setString(KEY_USERNAME, username);
  }

//memanggil username
  static Future<String> readUsername() async {
    final preference = await sharedpreferences;
    return preference.getString(KEY_USERNAME) ?? ''; //untuk mencegah data Null
  }

  //simpan password
  static Future savePassword(String password) async {
    final preference = await sharedpreferences;
    return preference.setString(KEY_PASSWORD, password);
  }

//memanggil password
  static Future<String> readPassword() async {
    final preference = await sharedpreferences;
    return preference.getString(KEY_PASSWORD) ?? ''; //untuk mencegah data Null
  }

  //simpan IsRemember
  static Future saveIsRemember(bool isremember) async {
    final preference = await sharedpreferences;
    return preference.setBool(KEY_ISREMEMBER, isremember);
  }

//memanggil IsRemember
  static Future<bool> readIsRemember() async {
    final preference = await sharedpreferences;
    return preference.getBool(KEY_ISREMEMBER) ??
        false; //untuk mencegah data Null
  }

  //simpan IsLogin
  static Future saveIsLogin(bool islogin) async {
    final preference = await sharedpreferences;
    return preference.setBool(KEY_ISLOGIN, islogin);
  }

//memanggil IsLogin
  static Future<bool> readIsLogin() async {
    final preference = await sharedpreferences;
    return preference.getBool(KEY_ISLOGIN) ?? false; //untuk mencegah data Null
  }

  //simpan token
  static Future saveToken(String token) async {
    final preference = await sharedpreferences;
    return preference.setString(KEY_TOKEN, token);
  }

//memanggil token
  static Future<String> readToken() async {
    final preference = await sharedpreferences;
    return preference.getString(KEY_TOKEN) ?? ''; //untuk mencegah data Null
  }

  // clear all data
  static Future clearAllData() async {
    final preference = await sharedpreferences;
    await Future.wait(<Future>[
      preference.setString(KEY_USERNAME, ''),
      preference.setString(KEY_PASSWORD, ''),
      preference.setBool(KEY_ISLOGIN, false),
      preference.setString(KEY_TOKEN, ''),
    ]);
  }
}
