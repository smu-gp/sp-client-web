import 'package:sp_client/repository/repositories.dart';

class LocalPreferenceRepository implements PreferenceRepository {
  Map<String, dynamic> _preferences = Map();

  LocalPreferenceRepository();

  @override
  bool getBool(String key) {
    return _preferences[key];
  }

  @override
  int getInt(String key) {
    return _preferences[key];
  }

  @override
  String getString(String key) {
    return _preferences[key];
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _preferences[key] = value;
    return false;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _preferences[key] = value;
    return false;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _preferences[key] = value;
    return false;
  }
}
