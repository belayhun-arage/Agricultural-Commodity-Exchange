import "../../libs.dart";

class ProductState{}

class MyProductsLoadSuccess extends ProductState{
  List<ProductPost> posts;
  MyProductsLoadSuccess(this.posts);
}
class MyProductsLoadFailed extends ProductState{
  final int statusCode;
  final String msg;
  MyProductsLoadFailed(this.statusCode, this.msg );
}
class MyProductInit extends ProductState{}

class MyProductsLoading extends ProductState{}

// 


class ProductsLoadSuccess extends ProductState {
  List<ProductPost> posts;
  ProductsLoadSuccess(this.posts);
}

class ProductLoadFailed extends ProductState{
  int statusCode;
  String msg ;
  
  ProductLoadFailed({ required this.statusCode , required this.msg });
}

class ProductInit extends ProductState{}

class ProductsLoading extends ProductState{}
