import 'package:ecommerce/models/addtocartmodel.dart';
import 'package:hive/hive.dart';

class AddtoCartBox{
   static Box<CartModels> getCartBox() =>
    Hive.box<CartModels>('AddtoCart');
}