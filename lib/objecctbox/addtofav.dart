// import 'package:ecommerce/models/postproductdetail.dart';
// import 'package:ecommerce/objectbox.g.dart';

// import '../models/favmodel.dart';

// class ObjectBox {
//   late final Store _store;
//   late final Box<DetailsModel> addtofav;
//   late final Box<FavModels> addtofavagain;

//   ObjectBox._init(this._store) {
//     addtofav = Box<DetailsModel>(_store);
//     addtofavagain = Box<FavModels>(_store);
//   }

//   static Future<ObjectBox> init() async {
//     final store = await openStore();
//     return ObjectBox._init(store);
//   }

//   DetailsModel? getitemFromFav(int id) => addtofav.get(id);
//   int insetToFav(DetailsModel detailsModel) => addtofav.put(detailsModel);
//   bool removeFromFav(int id) => addtofav.remove(id);
//   Stream<List<DetailsModel>> getFavProducts() => addtofav
//       .query()
//       .watch(triggerImmediately: true)
//       .map((event) => event.find());
// //fav model

//   FavModels? getitemFromFavagain(int id) => addtofavagain.get(id);
//   int insetToFavagain(FavModels favModels) => addtofavagain.put(favModels);
//   bool removeFromFavagain(int id) => addtofavagain.remove(id);
//   Stream<List<FavModels>> getFavProductsagain() => addtofavagain
//       .query()
//       .watch(triggerImmediately: true)
//       .map((event) => event.find());
// }
