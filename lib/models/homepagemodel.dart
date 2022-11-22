// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

import 'package:objectbox/objectbox.dart';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  
  HomePageModel({
    this.response,
    this.error,
    this.message,
    this.sliderArray,
    this.bottomSliderArray,
    this.categoryArray,
    this.dealsArray,
    this.isActive,
    this.updateType,
  });

  String? response;
  bool? error;
  String? message;
  List<SliderArray>? sliderArray;
  List<SliderArray>? bottomSliderArray;
  List<CategoryArray>? categoryArray;
  List<DealsArray>? dealsArray;
  bool? isActive;
  bool? updateType;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
        response: json["response"],
        error: json["error"],
        message: json["message"],
        sliderArray: List<SliderArray>.from(
            json["slider_array"].map((x) => SliderArray.fromJson(x))),
        bottomSliderArray: List<SliderArray>.from(
            json["bottom_slider_array"].map((x) => SliderArray.fromJson(x))),
        categoryArray: List<CategoryArray>.from(
            json["category_array"].map((x) => CategoryArray.fromJson(x))),
        dealsArray: List<DealsArray>.from(
            json["deals_array"].map((x) => DealsArray.fromJson(x))),
        isActive: json["is_active"],
        updateType: json["update_type"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "error": error,
        "message": message,
        "slider_array": List<dynamic>.from(sliderArray!.map((x) => x.toJson())),
        "bottom_slider_array":
            List<dynamic>.from(bottomSliderArray!.map((x) => x.toJson())),
        "category_array":
            List<dynamic>.from(categoryArray!.map((x) => x.toJson())),
        "deals_array": List<dynamic>.from(dealsArray!.map((x) => x.toJson())),
        "is_active": isActive,
        "update_type": updateType,
      };
}

class SliderArray {
  SliderArray({
    this.id,
    this.imagePath,
    this.maincatId,
    this.maincatName,
    this.productId,
  });
  
  String? id;
  String? imagePath;
  dynamic maincatId;
  String? maincatName;
  String? productId;

  factory SliderArray.fromJson(Map<String, dynamic> json) => SliderArray(
        id: json["ID"],
        imagePath: json["image_path"],
        maincatId: json["maincat_id"],
        maincatName: json["maincat_name"],
        productId: json["product_id"] == null ? null : json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "image_path": imagePath,
        "maincat_id": maincatId,
        "maincat_name": maincatName,
        "product_id": productId == null ? null : productId,
      };
}

class CategoryArray {
  CategoryArray({
    this.id,
    this.name,
    this.imagePath,
    this.nextCat,
  });

  String? id;
  String? name;
  String? imagePath;
  bool? nextCat;

  factory CategoryArray.fromJson(Map<String, dynamic> json) => CategoryArray(
        id: json["ID"],
        name: json["name"],
        imagePath: json["image_path"],
        nextCat: json["nextCat"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "name": name,
        "image_path": imagePath,
        "nextCat": nextCat,
      };
}

class DealsArray {
  DealsArray({
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

  String? id;
  String? name;
  String? categoryName;
  String? description;
  String? finalPrice;
  String? actualPrice;
  String? discount;
  String? qty;
  List<Variant>? variant;
  List<Image>? images;
  List<dynamic>? color;

  factory DealsArray.fromJson(Map<String, dynamic> json) => DealsArray(
        id: json["ID"],
        name: json["name"],
        categoryName: json["category_name"],
        description: json["description"],
        finalPrice: json["final_price"],
        actualPrice: json["actual_price"],
        discount: json["discount"],
        qty: json["qty"],
        variant:
            List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        color: List<dynamic>.from(json["color"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "name": name,
        "category_name": categoryName,
        "description": description,
        "final_price": finalPrice,
        "actual_price": actualPrice,
        "discount": discount,
        "qty": qty,
        "variant": List<dynamic>.from(variant!.map((x) => x.toJson())),
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

class Variant {
  Variant({
    this.id,
    this.weight,
    this.quantity,
    this.discount,
    this.finalPrice,
    this.actualPrice,
    this.productId,
    this.color,
  });

  String? id;
  String? weight;
  String? quantity;
  String? discount;
  String? finalPrice;
  String? actualPrice;
  String? productId;
  List<dynamic>? color;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["ID"],
        weight: json["weight"],
        quantity: json["quantity"],
        discount: json["discount"],
        finalPrice: json["final_price"],
        actualPrice: json["actual_price"],
        productId: json["product_id"],
        color: List<dynamic>.from(json["color"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "weight": weight,
        "quantity": quantity,
        "discount": discount,
        "final_price": finalPrice,
        "actual_price": actualPrice,
        "product_id": productId,
        "color": List<dynamic>.from(color!.map((x) => x)),
      };
}
