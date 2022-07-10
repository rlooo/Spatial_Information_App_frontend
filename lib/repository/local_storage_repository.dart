import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageRepository {
  // Create storage
  final _storage = new FlutterSecureStorage();

  Future<String?> getValue(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (error) {
      return null;
    }
  }

  Future<void> setValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (error) {
      return null;
    }
  }

  Future<void> deleteValue(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (exception) {
      print(exception);
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (exception) {
      print(exception);
    }
  }
}
