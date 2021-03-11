import 'dart:convert';

import 'package:abstract_db_resources/src/abstract_json_database.dart';
import 'package:core_resources/core_resources.dart';

///Abstraction of database storing records
///as json objects but exposing them as
///T objects, converted by the [adapter]
///field
class AbstractTDatabase<T> {
  AbstractTDatabase({
    required this.jsonDatabase,
    required this.adapter,
  });

  final AbstractJsonDatabase jsonDatabase;
  final T Function(Map<String, dynamic>) adapter;

  Map<String, dynamic> _serialize(T item) => jsonDecode(jsonEncode(item));

  List<Map<String, dynamic>> _serializeList(List<T> items) => items.map(_serialize).toList();

  T? _deserialize(Map<String, dynamic> json) => adapter(json);

  List<T> _deserializeList(List<Map<String, dynamic>> items) {
    return items.map(_deserialize).mapNotNull((e) => e).toList();
  }

  ///Store single item
  Future<int> insert(T item, {int? key}) {
    return jsonDatabase.insert(_serialize(item), key: key);
  }

  ///Store multiple items
  Future<void> insertAll(List<T> items) {
    return jsonDatabase.insertAll(_serializeList(items));
  }

  ///Store multiple items associating ids to each
  Future<void> insertAllWithKeys(Map<int, T> items) {
    return jsonDatabase.insertAllWithKeys(items.map((k, v) => MapEntry(k, _serialize(v))));
  }

  ///Erase the database and insert values
  Future<void> replaceAll(List<T> items) {
    return jsonDatabase.replaceAll(_serializeList(items));
  }

  ///Erase the database and insert values using identifiers
  Future<void> replaceAllWithKeys(Map<int, T> items) {
    return jsonDatabase.replaceAllWithKeys(items.map((k, v) => MapEntry(k, _serialize(v))));
  }

  ///Remove data, if [key] is defined, only the record
  ///identified will be deleted, otherwise erase all
  ///records
  Future<void> delete({int? key}) {
    return jsonDatabase.delete(key: key);
  }

  ///Get a record identified by the given [key]
  Future<T?> getSingle(int key) async {
    final json = await jsonDatabase.getSingle(key);
    if (json == null) return null;
    return _deserialize(json);
  }

  ///Get all records stored
  Future<List<T>> getAll() async {
    return _deserializeList(await jsonDatabase.getAll());
  }

  ///Stream of the latest records store
  Stream<List<T>> streamAll() {
    return jsonDatabase.streamAll().map(_deserializeList).asBroadcastStream();
  }

  ///Stream of the latest version of a record
  ///identified by the given [key]
  Stream<T?> streamSingle(int key) {
    return jsonDatabase
        .streamSingle(key)
        .map<T?>((json) => json == null ? null : _deserialize(json))
        .asBroadcastStream();
  }
}
