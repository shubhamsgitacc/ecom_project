// // To parse this JSON data, do
// //
// //     final mydata = mydataFromJson(jsonString);

// import 'dart:convert';

// Mydata mydataFromJson(String str) => Mydata.fromJson(json.decode(str));
// Mydata mysldrdataFromJson(String str) => Mydata.fromJson(json.decode(str));

// String mydataToJson(Mydata data) => json.encode(data.toJson());

// class Mydata {
//     Mydata({
//        this.response,
       
//         this.error,
//         this.message,
//         this.sliderArray,
//     });

//     String ? response;
//     bool ?error;
//     String ?message;
//     List<SliderArray>? sliderArray;

//     factory Mydata.fromJson(Map<String, dynamic> json) => Mydata(
//         response: json["response"],
//         error: json["error"],
//         message: json["message"],
//         sliderArray: List<SliderArray>.from(json["slider_array"].map((x) => SliderArray.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "response": response,
//         "error": error,
//         "message": message,
//         "slider_array": List<dynamic>.from(sliderArray!.map((x) => x.toJson())),
//     };
// }

// class SliderArray {
//     SliderArray({
//         this.id,
//         this.imagePath,
//         this.maincatId,
//         this.maincatName,
//         this.productId,
//     });

//     String?id;
//     String ?imagePath;
//     dynamic  maincatId;
//     String ?maincatName;
//     String ? productId;

//     factory SliderArray.fromJson(Map<String, dynamic> json) => SliderArray(
//         id: json["ID"],
//         imagePath: json["image_path"],
//         maincatId: json["maincat_id"],
//         maincatName: json["maincat_name"],
//         productId: json["product_id"] == null ? null : json["product_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "ID": id,
//         "image_path": imagePath,
//         "maincat_id": maincatId,
//         "maincat_name": maincatName,
//         "product_id": productId == null ? null : productId,
//     };
// }
