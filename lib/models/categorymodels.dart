// To parse this JSON data, do
//
//     final categorymodels = categorymodelsFromJson(jsonString);

import 'dart:convert';

Categorymodels categorymodelsFromJson(String str) =>
    Categorymodels.fromJson(json.decode(str));

String categorymodelsToJson(Categorymodels data) => json.encode(data.toJson());

class Categorymodels {
  Categorymodels({
    this.response,
    this.error,
    this.message,
    this.resultArray,
  });

  String? response;
  bool? error;
  String? message;
  List<ResultArray>? resultArray;

  factory Categorymodels.fromJson(Map<String, dynamic> json) => Categorymodels(
        response: json["response"],
        error: json["error"],
        message: json["message"],
        resultArray: List<ResultArray>.from(
            json["result_array"].map((x) => ResultArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "error": error,
        "message": message,
        "result_array": List<dynamic>.from(resultArray!.map((x) => x.toJson())),
      };
}

class ResultArray {
  ResultArray({
    this.id,
    this.name,
    this.products,
  });

  String? id;
  Name? name;
  List<Product>? products;

  factory ResultArray.fromJson(Map<String, dynamic> json) => ResultArray(
        id: json["ID"],
        name: nameValues.map[json["name"]],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "name": nameValues.reverse![name],
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

enum Name { QUILT_FITTED_FIBER_MATTRESS, RAZAI }

final nameValues = EnumValues({
  "Quilt Fitted Fiber Mattress": Name.QUILT_FITTED_FIBER_MATTRESS,
  "Razai": Name.RAZAI
});

class Product {
  Product({
    this.id,
    this.name,
    this.categoryName,
    this.finalPrice,
    this.actualPrice,
    this.discount,
    this.qty,
    this.description,
    this.images,
    this.variant,
    this.color,
  });

  String? id;
  String? name;
  Name? categoryName;
  String? finalPrice;
  String? actualPrice;
  String? discount;
  String? qty;
  String? description;
  List<Image>? images;
  List<Variant>? variant;
  List<dynamic>? color;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["ID"],
        name: json["name"],
        categoryName: nameValues.map[json["category_name"]],
        finalPrice: json["final_price"],
        actualPrice: json["actual_price"],
        discount: json["discount"],
        qty: json["qty"],
        description: json["description"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        variant:
            List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
        color: List<dynamic>.from(json["color"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "name": name,
        "category_name": nameValues.reverse![categoryName],
        "final_price": finalPrice,
        "actual_price": actualPrice,
        "discount": discount,
        "qty": qty,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "variant": List<dynamic>.from(variant!.map((x) => x.toJson())),
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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
