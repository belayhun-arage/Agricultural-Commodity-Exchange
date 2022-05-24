import 'package:agri_net_frontend/products/products.dart';

class ProductState {}

class GetProductListInItState extends ProductState {}

class GetProductListState extends ProductState {}

class ProductListFetchedState extends ProductState {
  List<Product> products;
  ProductListFetchedState(this.products);
}

class FailedToFechProducts extends ProductState {
  String msg;
  FailedToFechProducts({required this.msg});
}

class PostNewProductState extends ProductState {}

class NewProductPostedState extends ProductState {
  Product product;
  NewProductPostedState(this.product);
}

class FailedToPostNewProductState extends ProductState {
  String msg;
  FailedToPostNewProductState({required this.msg});
}
