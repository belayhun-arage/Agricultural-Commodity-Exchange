import '../../libs.dart';
import 'dart:convert';
import 'package:http/http.dart';

class StoreProvider {
  static Client client = new Client();
  StoreProvider();

  Future<NewStoreResponse> createStore(
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
    var response = await client.post(
        Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/admin/store/new"),
        body: jsonEncode({
          "name": storeName,
          "owner_id": ownerID,
          "address": {
            "kebele": kebele,
            "woreda": woreda,
            "city": city,
            "unique_address": uniqueAddress,
            "region": region,
            "zone": zone,
            "latitude": latitude,
            "longitude": longitude
          }
        }),
        headers: {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var newStore = jsonDecode(response.body);
      var theStore = newStore["store"];
      return NewStoreResponse(
          statusCode: response.statusCode,
          msg: newStore["msg"],
          newStore: new Store.fromJson(theStore));
    }
    return NewStoreResponse(
        statusCode: response.statusCode, msg: jsonDecode(response.body)["msg"]);
  }

  Future<StoresResponse> myStores(int ownerId) async {
    try {
      final queryParameters = {
        "id": ownerId,
      }.map((key, value) => MapEntry(key, value.toString()));

      var response = await client.get(
          Uri(
              scheme: "http",
              host: StaticDataStore.HOST,
              port: StaticDataStore.PORT,
              path: "api/merchant/stores",
              queryParameters: queryParameters),
          headers: {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"});
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> stores = jsonDecode(response.body);
        return StoresResponse.fromJson(stores);
      } else {
        return StoresResponse(
            statusCode: response.statusCode,
            msg: STATUS_CODES[response.statusCode] ?? "",
            stores: []);
      }
    } catch (e, a) {
      return StoresResponse(
          statusCode: 999, msg: "Something WentWrong", stores: []);
    }
  }
}
