import 'package:sembast/sembast.dart';

abstract class BaseDataSource<ModelT, KeyT> {
  final StoreRef<int, Map<String, Object?>> store;
  final Database database;

  String get idFieldName;

  BaseDataSource(
    this.database,
    String storeName,
  ) : this.store = intMapStoreFactory.store(storeName);

  ModelT objFromMap(Map<String, dynamic> map);
  Map<String, Object?> objToMap(ModelT obj);

  Future<int> add(ModelT obj) async {
    return await store.add(database, objToMap(obj));
  }

  Future<List<int>> addAll(List<ModelT> objList) async {
    return await store.addAll(
      database,
      objList.map<Map<String, Object?>>((ModelT obj) => objToMap(obj)).toList(),
    );
  }

  Future<int> count() async {
    return await store.count(database);
  }

  Future<List<ModelT>> filter({
    List<SortOrder>? sortOrders,
    List<Filter>? filters,
  }) async {
    //creating finder
    final finder = Finder(
      filter: filters != null ? Filter.and(filters) : null,
      sortOrders: sortOrders ?? [SortOrder(idFieldName)],
    );

    final recordSnapshots = await store.find(
      database,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      return objFromMap(snapshot.value);
    }).toList();
  }

  Future<List<ModelT>> all() async {
    final recordSnapshots = await store.find(
      database,
    );

    return recordSnapshots.map((snapshot) {
      return objFromMap(snapshot.value);
    }).toList();
  }

  Future<int> update(ModelT obj) async {
    final finder = Finder(filter: Filter.byKey(objToMap(obj)[idFieldName]));
    return await store.update(
      database,
      objToMap(obj),
      finder: finder,
    );
  }

  Future<int> delete(ModelT obj) async {
    final finder = Finder(filter: Filter.byKey(objToMap(obj)[idFieldName]));
    return await store.delete(
      database,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await store.drop(
      database,
    );
  }
}
