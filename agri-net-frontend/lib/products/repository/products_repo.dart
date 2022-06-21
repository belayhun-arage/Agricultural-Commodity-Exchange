import 'dart:ffi';

import "../../libs.dart";

class ProductsRepo {
  final ProductProvider provider;

  ProductsRepo(this.provider);

  Future<void> uplodProductImage(File imageFile, int p) async {
    return await provider.uploadImage2(imageFile, p);
  }

  Future<ProductPostResponse> createProductPost(ProductPostInput input) async {
    return this.provider.createProductPost(input);
  }

  Future<ProductsResponse> loadMyProductPosts() async {
    return this.provider.loadMyProductPosts();
  }

  Future<ProductsResponse> loadProducts(int offset, int limit) async {
    return this.provider.loadProducts(offset, limit);
  }

  Future<ProductPostResponse> getProductPostResponseByID(int id) async {
    return this.provider.getProductPostResponseByID(id);
  }
}
