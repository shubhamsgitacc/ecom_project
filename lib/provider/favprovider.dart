import 'package:ecommerce/hive/hivefav.dart';
import 'package:ecommerce/models/favmodel.dart';
import 'package:flutter/cupertino.dart';

class FavProivder extends ChangeNotifier {
  final box = FavBox.getFavBox();

  isFav(int id) async {
    FavModels? iss = box.get(id);
    // bool isexist = iss != null;
    // return isexist;
    // if (iss == null) {
    //   //   Future addtoFavHive(int id, String name, String image) async {
    //   //   final favmodels = FavModels(id: id, name: name, image: image);

    //   //   final favBox = FavBox.getFavBox();
    //   //   favBox.put(id, favmodels);

    //   //   print(favmodels);
    //   // }

    // }
  }

  isextist(int id) async{
    FavModels? iss = box.get(id);
    final isexist = iss != null;
    return isexist;
  }

  @override
  notifyListeners();
}
