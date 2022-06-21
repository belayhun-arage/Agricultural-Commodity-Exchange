import '../../libs.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductState>
    implements Cubit<ProductState> {
  final ProductsRepo repo;
  ProductsBloc({required this.repo}) : super(ProductInit()) {
    on<LoadProductsEvent>((event, emit) async {
      int offset = 0;
      int limit = 0;
      if (this.state is ProductsLoadSuccess) {
        offset = (this.state as ProductsLoadSuccess).posts.length;
        limit = offset + 20;
      } else {
        emit(ProductsLoading());
      }
      final response = await this.repo.loadProducts(offset, limit);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (this.state is ProductsLoadSuccess) {
          final thestate = this.state;
          (thestate as ProductsLoadSuccess).posts.addAll(response.posts);
          emit(ProductInit());
          emit(thestate);
        } else {
          emit(ProductsLoadSuccess(response.posts));
        }
      } else {
        if (!(this.state is ProductsLoadSuccess)) {
          emit(
            ProductLoadFailed(
              statusCode: response.statusCode,
              msg: response.msg,
            ),
          );
        }
      }
    });

    on<AddImageToPost>((event, emit) async {
      final response = await repo.uplodProductImage(event.imageFile, event.pID);
    });

    on<AddProduct>((event, emit) {
      if (this.state is ProductsLoadSuccess) {
        (this.state as ProductsLoadSuccess).posts.add(event.post);
        emit(this.state);
      } else {
        emit(ProductsLoadSuccess([event.post]));
      }
    });
  }

  Future<ProductPostResponse> createProductPost(ProductPostInput input) async {
    return await this.repo.createProductPost(input);
  }

  ProductPost? getProductPostByID(int id) {
    if (state is ProductsLoadSuccess) {
      for (final post in (state as ProductsLoadSuccess).posts) {
        if (post.id == id) {
          return post;
        }
      }
    }
    this.repo.getProductPostResponseByID(id).then((productPostGetResponse) {
      if (productPostGetResponse.crop != null &&
          productPostGetResponse.statusCode == 200) {
        this.add(AddProduct(productPostGetResponse.crop!));
      }
    });
    return null;
  }
}
