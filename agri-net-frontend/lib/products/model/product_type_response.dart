import "../../libs.dart";

class ProductTypesResponse {
  int statusCode;
  List<ProductType>  products;
  String msg;

  ProductTypesResponse({required this.statusCode, required this.products, required this.msg});

  factory ProductTypesResponse.fromJson(Map<String , dynamic> json){
    return ProductTypesResponse(
      msg : json["msg"]?? '' ,
      statusCode : json["status_code"]??999,
      products : ProductType.fromListOfJSON(json["products"]), 
    );
  }
}