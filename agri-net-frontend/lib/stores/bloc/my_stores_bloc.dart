import '../../libs.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState>
    implements Cubit<StoreState> {
  StoreRepo storeRepo;
  StoreBloc({required this.storeRepo}) : super(MyStoresInit()) {
    on<LoadMyStoresEvent>(
      (event, emit) async {
        if (!(this.state is MyStoresLoadedState)) {
          emit(LoadingMyStoresState());
        }
        final response = await storeRepo.myStores(event.ownerId);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (this.state is MyStoresLoadedState) {
            (this.state as MyStoresLoadedState)
                .myStores
                .addAll({event.ownerId: response.stores});
            emit(this.state);
          } else {
            print(response..stores);
            emit(MyStoresLoadedState(
                myStores: {event.ownerId: response.stores}));
          }
        } else {
          emit(LoadingStoresFailedState(
              statusCode: response.statusCode, msg: response.msg));
        }
      },
    );
  }

  Future<NewStoreResponse> createNewStore(
      CreateNewStoreEvent createNewStoreEvent) async {
    var newStoreRespo = await storeRepo.createMerchantStore(
        createNewStoreEvent.storeName,
        createNewStoreEvent.ownerID,
        createNewStoreEvent.kebele,
        createNewStoreEvent.woreda,
        createNewStoreEvent.city,
        createNewStoreEvent.unique_address,
        createNewStoreEvent.region,
        createNewStoreEvent.zone,
        createNewStoreEvent.latitude,
        createNewStoreEvent.longitude);
    return newStoreRespo;
  }
}
