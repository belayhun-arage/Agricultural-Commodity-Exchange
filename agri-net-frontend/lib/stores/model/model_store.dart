import '../../libs.dart';

class Store {
  int storeID;
  int ownerID;
  Address address;
  int? activeProducts;
  String storeName;
  int? activeContracts;
  DateTime createdAt;
  int createdBy;

  Store(
      {required this.storeID,
      required this.ownerID,
      this.activeProducts,
      required this.storeName,
      this.activeContracts,
      required this.address,
      required this.createdAt,
      required this.createdBy});

  factory Store.fromJson(json) {
    DateTime createdAt =
        DateTime.fromMillisecondsSinceEpoch((json["created_at"] ?? 0) * 1000);
    return Store(
        storeID: json["id"] ?? 9999,
        ownerID: json["owner_id"],
        activeProducts: json["active_products"],
        storeName: json["store_name"],
        activeContracts: json["active_contracts"],
        address: json["address"] != null
            ? Address.fromJson(json["address"])
            : Address.zeroAddress(),
        createdAt: createdAt,
        createdBy: json["created_by"]);
  }
}
