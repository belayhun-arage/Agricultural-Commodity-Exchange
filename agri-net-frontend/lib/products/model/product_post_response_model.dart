import "../../libs.dart";

class ProductPostInput {
  final int typeID;
  final double sellingPrice;
  final int storeid;
  final String description;
  final int quantity;
  final bool negotiablePrice;

  ProductPostInput({
    required this.typeID,
    required this.sellingPrice,
    required this.storeid,
    required this.description,
    required this.quantity,
    required this.negotiablePrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "type_id": this.typeID,
      "selling_price": this.sellingPrice,
      "store_id": this.storeid,
      "description": this.description,
      "quantity": this.quantity,
      "negotiable_price": this.negotiablePrice,
    };
  }
}

//

class ProductPostResponse {
  int statusCode;
  String msg;
  ProductPost? crop;

  ProductPostResponse(
      {required this.statusCode, required this.msg, required this.crop});

  factory ProductPostResponse.fromJson(Map<String, dynamic> json) {
    return ProductPostResponse(
      statusCode: json["status_code"] ?? 999,
      msg: json["msg"] ?? "",
      crop: (json["crop"] ?? json["post"]) != null
          ? ProductPost.fromJson(json["crop"])
          : null,
    );
  }
}

class ProductsResponse {
  int statusCode;
  String msg;
  List<ProductPost> posts;

  ProductsResponse(
      {required this.statusCode, required this.msg, required this.posts});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      statusCode: json["status_code"] ?? 999,
      msg: json["msg"] ?? STATUS_CODES[json["status_code"] ?? 999] ?? "",
      posts: json["posts"] == null
          ? []
          : (json["posts"] as List<dynamic>).map<ProductPost>((e) {
              return ProductPost.fromJson(e as Map<String, dynamic>);
            }).toList(),
    );
  }
}
