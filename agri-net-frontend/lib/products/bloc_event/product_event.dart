import "../../libs.dart";

class ProductEvent {}

class LoadMyProductsEvent extends ProductEvent {
  LoadMyProductsEvent();
}

class AddNewProduct extends ProductEvent {
  ProductPost post;
  AddNewProduct(this.post);
}

class AddProduct extends ProductEvent {
  ProductPost post;
  AddProduct(this.post);
}

class AddImageToPost extends ProductEvent {
  File imageFile;
  int pID;
  AddImageToPost({required this.imageFile, required this.pID});
}

class LoadProductsEvent extends ProductEvent {}

// class LoadProductsInit extends ProductEvent {}
