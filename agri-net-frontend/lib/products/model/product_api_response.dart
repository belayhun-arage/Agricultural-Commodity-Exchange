import '../../libs.dart';

class ProductResponse {
  int statusCode;
  String msg;
  Product? product;

  ProductResponse({required this.statusCode, required this.msg, this.product});
}
