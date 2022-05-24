import '../../libs.dart';

class Product {
  int pid;
  String productName;
  String productionArea;
  int unitId;
  double currentPrice;
  int createdBy;
  DateTime createdAt;
  DateTime lastUpdateTime;

  Product(
      {required this.pid,
      required this.productName,
      required this.productionArea,
      required this.unitId,
      required this.currentPrice,
      required this.createdBy,
      required this.createdAt,
      required this.lastUpdateTime});

  factory Product.fromJson(json) {
    return Product(
        pid: int.parse("${json['id']}"),
        productName: json["name"],
        productionArea: json["production_area"],
        unitId: json["unit_id"],
        currentPrice: json["current_price"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        lastUpdateTime: json["last_update_time"]);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "pid": this.pid,
  //     "productName": this.productName,
  //     "location": this.location,
  //     "amounte": this.amounte,
  //     "price": this.price
  //   };
  // }
}
