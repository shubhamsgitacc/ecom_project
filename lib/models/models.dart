// To parse this JSON data, do
//
//     final mydata = mydataFromJson(jsonString);

import 'dart:convert';

// Mydata mydataFromJson(String str) => Mydata.fromJson(json.decode(str));

String mydataToJson(Mydata data) => json.encode(data.toJson());

class Mydata {
    Mydata({
        this.dealsArray,
    });

    List<DealsArray>? dealsArray;

    factory Mydata.fromJson(Map<String, dynamic> json) => Mydata(
        dealsArray: List<DealsArray>.from(json["deals_array"].map((x) => DealsArray.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "deals_array": List<dynamic>.from(dealsArray!.map((x) => x.toJson())),
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

    String ? id;
    String ? name;
    String ?categoryName;
    String ?description;
    String ?finalPrice;
    String ?actualPrice;
    String ?discount;
    String ?qty;
    List<Variant>? variant;
    List<Imagess>? images;
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
        variant: List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
        images: List<Imagess>.from(json["images"].map((x) => Imagess.fromJson(x))),
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

class Imagess {
    Imagess({
        this.imgId,
        this.imgProduct,
    });

    String ?imgId;
    String ?imgProduct;

    factory Imagess.fromJson(Map<String, dynamic> json) => Imagess(
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
    String ?quantity;
    String ?discount;
    String ?finalPrice;
    String ?actualPrice;
    String ?productId;
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
