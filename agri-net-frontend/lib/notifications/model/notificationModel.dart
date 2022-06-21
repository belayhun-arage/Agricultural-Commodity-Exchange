import '../../libs.dart';

class ProductNotification {
  User poster;
  // Product product;
  String location;
  double distance;
  ProductNotification(
      {required this.poster,
      // required this.product,
      required this.distance,
      required this.location});

  ProductNotification fromJson(json) {
    return ProductNotification(
        poster: json["json"],
        // product: json["product"],
        distance: json["distance"],
        location: json['location']);
  }

  Map<String, dynamic> toJson(ProductNotification n) {
    return {
      "poster": n.poster,
      // "product": n.product,
      "distance": n.distance,
      "location": n.location
    };
  }
}
