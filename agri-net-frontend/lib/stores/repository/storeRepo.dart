import '../../libs.dart';

class StoreRepo {
  StoreProvider storeProvider;
  StoreRepo({required this.storeProvider});

  Future<NewStoreResponse> createMerchantStore(
    String storeName,
    int ownerID,
    String kebele,
    String woreda,
    String city,
    String uniqueAddress,
    String region,
    String zone,
    double latitude,
    double longitude,
  ) async {
    return await storeProvider.createStore(
      storeName,
      ownerID,
      kebele,
      woreda,
      city,
      uniqueAddress,
      region,
      zone,
      latitude,
      longitude,
    );
  }

  Future<StoresResponse> myStores(int ownerId) async {
    return await storeProvider.myStores(ownerId);
  }
}
