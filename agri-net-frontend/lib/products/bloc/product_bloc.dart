import '../../libs.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>
    implements Cubit<ProductState> {
  final ProductRepo repo;
  ProductBloc({required this.repo}) : super(GetProductListInItState());

  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is GetProductListEvent) {
      final productList = await repo.getProductList();
      if (productList != null) {
        yield (ProductListFetchedState(productList));
      }
      yield (FailedToFechProducts(msg: "No products posted yet"));
    }
    if (event is ProductListFetchedEvent) {
      yield (ProductListFetchedState(event.products));
    }
    if (event is NewProductPostedEvent) {
      yield (NewProductPostedState(event.product));
    }
    if (event is FailedToPostNewProductState) {
      yield (FailedToPostNewProductState(
          msg: "Error while posting new product"));
    }
  }

  Future<ProductState?> createNewProduct(PostNewProductEvent event) async {
    final productState = await repo.createProduct(event.unit_id,
        event.productName, event.production_area, event.current_price);
    if (productState != null) {
      this.mapEventToState(
          NewProductPostedEvent(product: productState.product!));
      return NewProductPostedState(productState.product!);
    }
    return FailedToPostNewProductState(msg: "Failure");
  }
}
