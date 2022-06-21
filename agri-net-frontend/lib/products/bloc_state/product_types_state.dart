import "../../libs.dart";

class ProductTypeState{}

class ProductTypeInit extends ProductTypeState{}

class ProductTypeLoadSuccess extends ProductTypeState{
  List<ProductType> products ; 
  ProductTypeLoadSuccess(this.products);

  ProductType? getProductTypeByID(int id) {
    if (this.products.length>0){
      for (ProductType t in this.products){
        if (t.id == id){
          return t;
        }
      }
    }
    return null;
  }
}

class ProductTypeLoadFailure extends ProductTypeState{
  ProductTypesResponse response ;
  ProductTypeLoadFailure(this.response);
}