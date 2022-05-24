import '../../libs.dart';

class ProductRepo {
  ProductProvider? provider;
  ProductRepo({required this.provider});

  Future<ProductResponse> createProduct(int unit_id, String productName,
      String production_area, double current_price) {
    return this
        .provider!
        .createProduct(unit_id, productName, production_area, current_price);
  }

  Future<List<Product>> getProductList() {
    return this.provider!.getProducts();
  }
}
