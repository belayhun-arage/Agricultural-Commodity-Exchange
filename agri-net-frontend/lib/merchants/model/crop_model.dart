class Crop {
  int cropID;
  int typeID;
  List<String> images;
  bool negotiable;
  int remainingQuantity;
  String description;
  int storeID;
  int agentID;
  DateTime createdAt;
  double sellingPrice;
  int addressId;

  Crop(
      {required this.cropID,
      required this.typeID,
      required this.images,
      required this.negotiable,
      required this.description,
      required this.addressId,
      required this.agentID,
      required this.storeID,
      required this.createdAt,
      required this.remainingQuantity,
      required this.sellingPrice});
}
