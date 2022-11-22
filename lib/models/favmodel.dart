import 'package:hive_flutter/hive_flutter.dart';
part 'favmodel.g.dart';

@HiveType(typeId: 0)
class FavModels extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;
  FavModels({this.id, this.name, this.image});

  FavModels.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        image = res['image'];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'image': image};
  }
}
