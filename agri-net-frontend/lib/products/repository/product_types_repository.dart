import "../../libs.dart";

class ProductTypesRepository {
  ProductTypesProvider provider;

  ProductTypesRepository(this.provider);

  static int lock = 0;
  Future<ProductTypesResponse> loadProducts() async {
    if (lock > 0) {
      Future.delayed(Duration(seconds: 1));
      return ProductTypesResponse(statusCode: 1000, products: [], msg: "locked");
    }
    lock += 1;
    final response = await this.provider.loadProducts();
    lock -= 1;
    return response;
  }

  Future<ProductTypesResponse> searchProducts(String text) async {
    // if (lock > 0) {
    //   Future.delayed(Duration(seconds: 1));
    //   return ProductsResponse(statusCode: 1000, products: [], msg: "locked");
    // }
    // lock += 1;
    final response = await this.provider.searchProducts(text);
    // lock -= 1;
    return response;
  }

  Future<StatusAndMessage> subscribeForProduct(int productID) async {
    return this.provider.subscribeForProduct(productID);
  }

  Future<StatusAndMessage> unSubscribeForProduct(int productID) async {
    return this.provider.unSubscribeForProduct(productID);
  }
  
}
