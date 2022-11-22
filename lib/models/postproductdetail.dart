// To parse this JSON data, do
//
//     final DetailsModel = DetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:objectbox/objectbox.dart';

DetailsModel DetailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String DetailsModelToJson(DetailsModel data) => json.encode(data.toJson());

@Entity()
class DetailsModel {
  DetailsModel({
    this.ids = 0,
    this.response,
    this.error,
    this.message,
    this.id,
    this.name,
    this.categoryName,
    this.description,
    this.finalPrice,
    this.actualPrice,
    this.discount,
    this.qty,
    this.variant,
    this.images,
    this.color,
  });
  @Id()
  int? ids;
  String? finalimage;
  String? response;
  bool? error;
  String? message;
  String? id;
  String? name;
  String? categoryName;
  String? description;
  String? finalPrice;
  String? actualPrice;
  String? discount;
  String? qty;
  List<dynamic>? variant;
  List<Image>? images;
  List<dynamic>? color;

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        response: json["response"],
        error: json["error"],
        message: json["message"],
        id: json["ID"],
        name: json["name"],
        categoryName: json["category_name"],
        description: json["description"],
        finalPrice: json["final_price"],
        actualPrice: json["actual_price"],
        discount: json["discount"],
        qty: json["qty"],
        variant: List<dynamic>.from(json["variant"].map((x) => x)),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        color: List<dynamic>.from(json["color"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "error": error,
        "message": message,
        "ID": id,
        "name": name,
        "category_name": categoryName,
        "description": description,
        "final_price": finalPrice,
        "actual_price": actualPrice,
        "discount": discount,
        "qty": qty,
        "variant": List<dynamic>.from(variant!.map((x) => x)),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "color": List<dynamic>.from(color!.map((x) => x)),
      };
}

class Image {
  Image({
    this.imgId,
    this.imgProduct,
  });

  String? imgId;
  String? imgProduct;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        imgId: json["img_id"],
        imgProduct: json["img_product"],
      );

  Map<String, dynamic> toJson() => {
        "img_id": imgId,
        "img_product": imgProduct,
      };
}
