import 'package:abstract_db_resources/abstract_db_resources.dart';

class BaseRepository<T> {
  BaseRepository({required this.db});

  final AbstractTDatabase<T> db;

  ///Store single item
  Future<int> insert(T item, {int? key}) => db.insert(item, key: key);

  ///Store multiple items
  Future<void> insertAll(Iterable<T> items) => Future.wait(items.map((e) => insert(e)));

  ///Store multiple items associating ids to each
  Future<void> insertAllWithKeys(Map<int, T> items) {
    return Future.wait(items.entries.map((e) => insert(e.value, key: e.key)));
  }

  ///Erase the database and insert values
  Future<void> replaceAll(Iterable<T> items) async {
    await clear();
    return insertAll(items);
  }

  ///Erase the database and insert values using identifiers
  Future<void> replaceAllWithKeys(Map<int, T> items) async {
    await clear();
    return insertAllWithKeys(items);
  }

  ///Remove data, if [key] is defined, only the record
  ///identified will be deleted, otherwise erase all
  ///records
  Future<void> delete({int? key}) => db.delete(key: key);

  ///Remove all records from the database
  Future<void> clear() => delete();

  ///Get a record identified by the given [key]
  Future<T?> getSingle(int key) async => db.getSingle(key);

  ///Get all records stored
  Future<List<T>> getAll() async => db.getAll();

  ///Stream of the latest records store
  Stream<List<T>> streamAll() => db.streamAll();

  ///Stream of the latest version of a record
  ///identified by the given [key]
  Stream<T?> streamSingle(int key) => db.streamSingle(key);
}
