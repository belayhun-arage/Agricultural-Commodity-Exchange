import "../../libs.dart";

class ProductTypeBloc extends Bloc<ProductTypeEvent, ProductTypeState> {
  ProductTypesRepository repository;

  ProductTypeBloc(this.repository) : super(ProductTypeInit()) {
    on<ProductTypesLoadEvent>((event, emit) async {
      final response = await this.repository.loadProducts();
      if (response.statusCode == 200) {
        // print("Products Loaded : ${response.products.length}");
        emit(ProductTypeLoadSuccess(response.products));
      } else if (response.statusCode == 1000) {
        emit(this.state);
      } else {
        print(response.msg);
        emit(ProductTypeLoadFailure(response));
      }
    });
    on<SearchProductTypeEvent>((event, emit) async {
      final response = await this.repository.searchProducts(event.text);
      if (response.statusCode == 200) {
        emit(ProductTypeInit());
        emit(ProductTypeLoadSuccess(response.products));
      } else {
        emit(this.state);
      }
    });
    on<ProductTypeUpdateEvent>((event, emit) {
      print("Event Called");
      if (this.state is ProductTypeLoadSuccess) {
        for (final pr in (this.state as ProductTypeLoadSuccess).products) {
          if (pr.id == event.update.productID) {
            pr.currentPrice = event.update.cost;
            print("Updating....");
            emit(ProductTypeLoadSuccess(
                (this.state as ProductTypeLoadSuccess).products));
          }
        }
      }
    });
  }

  // subscribeForProduct ...
  Future<StatusAndMessage> subscribeForProduct(int productID) async {
    return this.repository.subscribeForProduct(productID);
  }

  Future<StatusAndMessage> unSubscribeForProduct(int productID) async {
    return this.repository.unSubscribeForProduct(productID);
  }
}
