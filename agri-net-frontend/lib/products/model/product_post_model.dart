import "../../libs.dart";

class ProductPost {
  int id;
  int typeId;
  int remainingQuantity;
  String description;
  bool negotiable;
  double sellingPrice;
  Address address;
  List<int> images;
  int createdAt;
  int storeId;
  int agentId;
  bool storeOwned;

  ProductPost(
      {required this.id,
      required this.typeId,
      required this.remainingQuantity,
      required this.description,
      required this.negotiable,
      required this.sellingPrice,
      required this.address,
      required this.images,
      required this.createdAt,
      required this.storeId,
      required this.agentId,
      required this.storeOwned});

  factory ProductPost.fromJson(Map<String, dynamic> json) {
    print(json['images']);
    return ProductPost(
      id: json['id'],
      typeId: json['type_id'],
      remainingQuantity: json['remaining_quantity'],
      description: json['description'],
      negotiable: json['negotiable'],
      sellingPrice: double.parse("${json['selling_price']}"),
      address: json['address'] != null
          ? new Address.fromJson(json['address'])
          : Address.zeroAddress(),
      images: (json['images'] ?? []).map<int>((e) {
            return (e as int);
          }).toList() ??
          [],
      createdAt: json['created_at'],
      storeId: json['store_id'],
      agentId: json['agent_id'],
      storeOwned: json['store_owned'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['remaining_quantity'] = this.remainingQuantity;
    data['description'] = this.description;
    data['negotiable'] = this.negotiable;
    data['selling_price'] = this.sellingPrice;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['images'] = this.images;
    data['created_at'] = this.createdAt;
    data['store_id'] = this.storeId;
    data['agent_id'] = this.agentId;
    data['store_owned'] = this.storeOwned;
    return data;
  }
  
}
