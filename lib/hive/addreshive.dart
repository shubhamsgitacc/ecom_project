

import 'package:ecommerce/models/address.dart';
import 'package:hive/hive.dart';

class AddressBox {
  static Box<Addressmodel> getAddressBox() => Hive.box<Addressmodel>('Address');

}
