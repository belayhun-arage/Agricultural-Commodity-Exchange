import '../../libs.dart';

class ProductEvent {}

class GetProductListEvent extends ProductEvent {}

class ProductListFetchedEvent extends ProductEvent {
  List<Product> products;
  ProductListFetchedEvent(this.products);
}

class PostNewProductInit extends ProductEvent {}

class PostNewProductEvent extends ProductEvent {
  int unit_id;
  String productName;
  String production_area;
  double current_price;

  PostNewProductEvent(
      {required this.unit_id,
      required this.productName,
      required this.production_area,
      required this.current_price});
}

class NewProductPostedEvent extends ProductEvent {
  Product product;
  NewProductPostedEvent({required this.product});
}

class FailedToPostNewProductEvent extends ProductEvent {
  String msg;
  FailedToPostNewProductEvent({required this.msg});
}
