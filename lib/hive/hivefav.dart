import 'package:ecommerce/models/favmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavBox {
  static Box<FavModels> getFavBox() => Hive.box<FavModels>('AddtoFav');


}

