
import 'package:hive/hive.dart';
part 'address.g.dart';

@HiveType(typeId: 3)

class Addressmodel  extends HiveObject{
  @HiveField(0)
  String? address;
  @HiveField(1)
  int? mobileno;
  Addressmodel({this.address, this.mobileno});
}
