import 'package:hive_flutter/hive_flutter.dart';
part 'addtocartmodel.g.dart';

@HiveType(typeId: 2)
class CartModels  extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;
  @HiveField(3)
  String? actualprice;
  @HiveField(4)
  String? finalprice;
  @HiveField(5)
  int? quantity;
  @HiveField(6)
  String? weight;
  CartModels(
      {this.id,
      this.name,
      this.image,
      this.actualprice,
      this.finalprice,
      this.quantity = 1,
      this.weight});

  CartModels.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        image = res['image'],
        actualprice = res['actualprice'],
        finalprice = res['finalprice'],
        quantity = res['quantity'],
        weight = res['weight'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'actualprice': actualprice,
      'finalprice': finalprice,
      'quantity': quantity,
      'weight': weight
    };
  }
}
