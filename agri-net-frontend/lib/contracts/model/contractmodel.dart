import 'package:agri_net_frontend/products/products.dart';

class Contract {
  // Product product;
  double distance;
  double quantity;
  DateTime expiryDate;
  int sellerID;
  int buyyerID;

  Contract(
      {
      // required this.product,
      required this.distance,
      required this.quantity,
      required this.expiryDate,
      required this.buyyerID,
      required this.sellerID});

  Contract fromJson(json) {
    return Contract(
        // product: json['product'],
        distance: json["distance"],
        quantity: json["quantity"],
        expiryDate: json["expiryDate"],
        buyyerID: json["buyyerID"],
        sellerID: json["sellerID"]);
  }

  Map<String, dynamic> toJson(Contract c) {
    return {
      // "product": c.product,
      "distance": c.distance,
      "quantity": c.quantity,
      "expirydate": c.expiryDate,
      "buyyerID": c.buyyerID,
      "sellerID": c.sellerID
    };
  }
}
