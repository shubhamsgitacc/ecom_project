// import 'package:ecommerce/models/favmodel.dart';
// import 'package:ecommerce/objectbox.g.dart';

// class ObjectBox {
//   // late final Store _store;
//   // late final Box<FavModels> _favModels;

//   // ObjectBox._init(this._store) {
//     // _favModels = Box<FavModels>(_store);
//   }

//   static Future<ObjectBox> init() async {
//     // final store = await openStore();

//     return ObjectBox._init(store);
//   }

//   FavModels? getFavModels(int id) => _favModels.get(id);

//   Stream<List<FavModels>> getFavModelss() => _favModels
//       .query()
//       .watch(triggerImmediately: true)
//       .map((query) => query.find());

//   int insertFavModels(FavModels favModels) => _favModels.put(favModels);

//   bool deleteUser(int id) => _favModels.remove(id);
//    usercount() => _favModels.count();
// }
