class Product {
  int pid;
  String name;
  String production_area;
  int unit_id;
  double currentPrice;
  int createdBy;
  DateTime createdAt;
  DateTime lastUpdateTime;

  Product(
      {required this.pid,
      required this.name,
      required this.production_area,
      required this.unit_id,
      required this.currentPrice,
      required this.createdBy,
      required this.createdAt,
      required this.lastUpdateTime});

  factory Product.fromJson(json) {
    return Product(
        pid: int.parse("${json['id']}"),
        name: json["name"],
        production_area: json["production_area"],
        unit_id: json["unit_id"],
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
