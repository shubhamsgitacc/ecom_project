// // // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

// class Welcome {
//     Welcome({
//         this.responsex,
//         this.errorx,
//         this.messagex,
//          this.sliderArrayx,
//          this.bottomSliderArrayx,
//         this.categoryArrayx,
//        this.dealsArrayx,
//        this.isActivex,
//         this.updateTypex,
//     });

//     String ?responsex;
//     bool ?errorx;
//     String ? messagex;
//     List <SliderArray> ?sliderArrayx;
//     List <SliderArray> ?bottomSliderArrayx;
//     List <CategoryArray>? categoryArrayx;
//     List <DealsArray> ?dealsArrayx;
//     bool ?isActivex;
//     bool ? updateTypex;

//     factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         responsex: json["response"],
//         errorx: json["error"],
//         messagex: json["message"],
//         sliderArrayx: List<SliderArray>.from(json["slider_array"].map((x) => SliderArray.fromJson(x))),
//         bottomSliderArrayx: List<SliderArray>.from(json["bottom_slider_array"].map((x) => SliderArray.fromJson(x))),
//         categoryArrayx: List<CategoryArray>.from(json["category_array"].map((x) => CategoryArray.fromJson(x))),
//         dealsArrayx: List<DealsArray>.from(json["deals_array"].map((x) => DealsArray.fromJson(x))),
//         isActivex: json["is_active"],
//         updateTypex: json["update_type"],
//     );

//     Map<String, dynamic> toJson() => {
//         "response": responsex,
//         "error": errorx,
//         "message": messagex,
//         "slider_array": List<dynamic>.from(sliderArrayx!.map((x) => x.toJson())),
//         "bottom_slider_array": List<dynamic>.from(bottomSliderArrayx!.map((x) => x.toJson())),
//         "category_array": List<dynamic>.from(categoryArrayx!.map((x) => x.toJson())),
//         "deals_array": List<dynamic>.from(dealsArrayx!.map((x) => x.toJson())),
//         "is_active": isActivex,
//         "update_type": updateTypex,
//     };
// }

// class SliderArray {
//     SliderArray({
//         this.idx,
//         this.imagePathx,
//         this.maincatIdx,
//         this.maincatNamex,
//         this.productIdx,
//     });

//     String ? idx;
//     String ? imagePathx;
//     dynamic ? maincatIdx;
//     String ? maincatNamex;
//     String ? productIdx;

//     factory SliderArray.fromJson(Map<String, dynamic> json) => SliderArray(
//         idx: json["ID"],
//         imagePathx: json["image_path"],
//         maincatIdx: json["maincat_id"],
//         maincatNamex: json["maincat_name"],
//         productIdx: json["product_id"] == null ? null : json["product_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "ID": idx,
//         "image_path": imagePathx,
//         "maincat_id": maincatIdx,
//         "maincat_name": maincatNamex,
//         "product_id": productIdx == null ? null : productIdx,
//     };
// }

// class CategoryArray {
//     CategoryArray({
//         this.idx,
//         this.namex,
//         this.imagePathx,
//         this.nextCatx,
//     });

//     String ? idx;
//     String ? namex;
//     String ? imagePathx;
//     bool ? nextCatx;

//     factory CategoryArray.fromJson(Map<String, dynamic> json) => CategoryArray(
//         idx: json["ID"],
//         namex: json["name"],
//         imagePathx: json["image_path"],
//         nextCatx: json["nextCat"],
//     );

//     Map<String, dynamic> toJson() => {
//         "ID": idx,
//         "name": namex,
//         "image_path": imagePathx,
//         "nextCat": nextCatx,
//     };
// }

// class DealsArray {
//     DealsArray({
//         this.idx,
//         this.namex,
//         this.categoryNamex,
//         this.descriptionx,
//         this.finalPricex,
//         this.actualPricex,
//         this.discountx,
//         this.qtyx,
//         this.variantx,
//         this.imagesx,
//         this.colorx,
//     });

//     String ? idx;
//     String ? namex;
//     String ?categoryNamex;
//     String ?descriptionx;
//     String ?finalPricex;
//     String ?actualPricex;
//     String ?discountx;
//     String ?qtyx;
//       List<Variant>? variantx;
//     List<Images> ?imagesx;
//     List<dynamic> ?colorx;

//     factory DealsArray.fromJson(Map<String, dynamic> json) => DealsArray(
//         idx: json["ID"],
//         namex: json["name"],
//         categoryNamex: json["category_name"],
//         descriptionx: json["description"],
//         finalPricex: json["final_price"],
//         actualPricex: json["actual_price"],
//         discountx : json["discount"],
//         qtyx: json["qty"],
//         variantx: List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
//         imagesx: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
//         colorx: List<dynamic>.from(json["color"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "ID": idx,
//         "name": namex,
//         "category_name": categoryNamex,
//         "description": descriptionx,
//         "final_price": finalPricex,
//         "actual_price": actualPricex,
//         "discount": discountx,
//         "qty": qtyx,
//         "variant": List<dynamic>.from(variantx!.map((x) => x.toJson())),
//         "images": List<dynamic>.from(imagesx!.map((x) => x.toJson())),
//         "color": List<dynamic>.from(colorx!.map((x) => x)),
//     };
// }

// class Images {
//     Images({
//         this.imgIdx,
//         this.imgProductx,
//     });

//     String ? imgIdx;
//     String ? imgProductx;

//     factory Images.fromJson(Map<String, dynamic> json) => Images(
//         imgIdx: json["img_id"],
//         imgProductx: json["img_product"],
//     );

//     Map<String, dynamic> toJson() => {
//         "img_id": imgIdx,
//         "img_product": imgProductx
//     };
// }

// class Variant {
//     Variant({
//         this.idx,
//         this.weightx,
//         this.quantityx,
//         this.discountx,
//         this.finalPricex,
//         this.actualPricex,
//         this.productIdx,
//         // this.color,
//         this.colorNamex,
//         // this.colorImg,
//     });

//     String ? idx;
//     String ? weightx;
//     String ? quantityx;
//     String ? discountx;
//     String ?finalPricex;
//     String ?actualPricex;
//     String ? productIdx;
//     // List<Variant> color;
//     String ?colorNamex;
//     // List<dynamic> colorImg;

//     factory Variant.fromJson(Map<String, dynamic> json) => Variant(
//         idx: json["ID"],
//         weightx: json["weight"] == null ? null : json["weight"],
//         quantityx: json["quantity"],
//         discountx: json["discount"],
//         finalPricex: json["final_price"],
//         actualPricex: json["actual_price"],
//         productIdx: json["product_id"],
//         // color: json["color"] == null ? null : List<Variant>.from(json["color"].map((x) => Variant.fromJson(x))),
//         colorNamex: json["color_name"] == null ? null : json["color_name"],
//         // colorImg: json["color_img"] == null ? null : List<dynamic>.from(json["color_img"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "ID": idx,
//         "weight": weightx == null ? null : weightx,
//         "quantity": quantityx,
//         "discount": discountx,
//         "final_price": finalPricex,
//         "actual_price": actualPricex,
//         "product_id": productIdx,
//         // "color": color == null ? null : List<dynamic>.from(color.map((x) => x.toJson())),
//         "color_name": colorNamex == null ? null : colorNamex,
//         // "color_img": colorImg == null ? null : List<dynamic>.from(colorImg.map((x) => x)),
//     };
// }
