import '../../libs.dart';

class ProductRepo {
  ProductProvider? provider;
  ProductRepo({required this.provider});

  Future<ProductResponse> createProduct(int unitId, String productName,
      String productionArea, double currentPrice) {
    return this
        .provider!
        .createProduct(unitId, productName, productionArea, currentPrice);
  }

  Future<List<Product>> getProductList() {
    return this.provider!.getProducts();
  }
}
