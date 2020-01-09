import 'dart:convert';

import 'package:core_resources/core_resources.dart';
import 'package:sembast_db_resources/sembast_db_resources.dart';

import '../sembast_db_resources.dart';

///Create a default instace of a sembast database using the file name 'app.db'
Future<Database> createDefaultSembastDatabase() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  return databaseFactoryIo.openDatabase(join(appDocDir.path, 'app.db'));
}

typedef JsonAdapter<T> = T Function(Map<String, dynamic>);

extension DatabaseExtensions on Future<Database> {
  ///Get records from the given store as maps of int keys and T type values
  Future<Map<int, T>> getAll<T>(String storeName, JsonAdapter<T> adapter) async {
    return (await _get(storeName)).map((k, v) => MapEntry(k, adapter(v)));
  }

  ///Get records from the given store as maps of int keys and json values
  Future<Map<int, Map<String, dynamic>>> getAllJsons(String storeName) async => _get(storeName);

  ///Get a record on the given store identified by the given key
  Future<T> getSingleWithStringKey<T>(String storeName, String key, JsonAdapter<T> adapter) async {
    final store = stringMapStoreFactory.store(storeName);
    return adapter(await store.record(key).get(await this));
  }

  ///Get a record on the given store identified by the given key
  Future<T> getSingleWithIntKey<T>(String storeName, int key, JsonAdapter<T> adapter) async {
    final store = intMapStoreFactory.store(storeName);
    return adapter(await store.record(key).get(await this));
  }

  ///Insert the given value into a store, if [key] is defined and exists
  ///on store, the old value will be replaced
  Future<void> insertWithStringKey<T>(String storeName, T value, {String key}) async {
    return await insertJsonWithStringKey(storeName, jsonDecode(jsonEncode(value)), key: key);
  }

  ///Insert the given value into a store, if [key] is defined and exists
  ///on store, the old value will be replaced
  Future<void> insertJsonWithStringKey(
    String storeName,
    Map<String, dynamic> value, {
    String key,
  }) async {
    final store = stringMapStoreFactory.store(storeName);
    await store.record(key).put(await this, value);
  }

  ///Insert the given value into a store, if [key] is defined and exists
  ///on store, the old value will be replaced, finally returning the key of the
  ///created or updated value
  Future<int> insert<T>(String storeName, T value, {int key}) async {
    return await insertJson(storeName, jsonDecode(jsonEncode(value)));
  }

  ///Insert the given value into a store, if [key] is defined and exists
  ///on store, the old value will be replaced, finally returning the key of the
  ///created or updated value
  Future<int> insertJson(String storeName, Map<String, dynamic> value, {int key}) async {
    final store = intMapStoreFactory.store(storeName);
    if (key != null) {
      await store.record(key).put(await this, value);
      return key;
    } else {
      return await store.add(await this, value);
    }
  }

  ///Insert the given values to the database
  Future<void> insertAll<T>(String storeName, List<T> values) async {
    insertAllJsons(
      storeName,
      values.map<Map<String, dynamic>>((e) {
        return jsonDecode(jsonEncode(e));
      }).toList(),
    );
  }

  ///Insert the given values to the database
  Future<void> insertAllJsons(String storeName, List<Map<String, dynamic>> values) async {
    final store = intMapStoreFactory.store(storeName);
    await store.addAll(await this, values);
  }

  Future<Map<int, Map<String, dynamic>>> _get(String storeName) async {
    final store = intMapStoreFactory.store(storeName);
    return (await store.query().getSnapshots(await this)).associate<int, Map<String, dynamic>>((e) {
      return MapEntry(e.key, e.value);
    });
  }
}