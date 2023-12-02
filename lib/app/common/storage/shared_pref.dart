import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref? _object;

  factory SharedPref() {
    if (_object == null) {
      return _object = SharedPref._();
    } else {
      return _object!;
    }
  }

  SharedPref._();

  Future<SharedPreferences> get spDb async => await SharedPreferences.getInstance();


  void setStringList(String key, List<String> value) async {
    final preference = await spDb;
    preference.setStringList(key, value);
  }

  void setString(String key, {String value = ''}) async {
    final preference = await spDb;
    preference.setString(key, value);
  }

  void setDouble(String key, {double value = 0}) async {
    final preference = await spDb;
    preference.setDouble(key, value);
  }

  void setInt(String key, {int value = 0}) async {
    final preference = await spDb;
    preference.setInt(key, value);
  }

  void setBool(String key, {bool value = false}) async {
    final preference = await spDb;
    preference.setBool(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    final preference = await spDb;
    return preference.getStringList(key);
  }

  Future<String?> getString(String key) async {
    final preference = await spDb;
    return preference.getString(key);
  }

  Future<double?> getDouble(String key) async {
    final preference = await spDb;
    return preference.getDouble(key);
  }

  Future<int?> getInt(String key) async {
    final preference = await spDb;
    return preference.getInt(key);
  }

  Future<bool?> getBool(String key) async {
    final preference = await spDb;
    return preference.getBool(key);
  }

  Future remove(String key) async {
    final preference = await spDb;
    return preference.remove(key);
  }
}
