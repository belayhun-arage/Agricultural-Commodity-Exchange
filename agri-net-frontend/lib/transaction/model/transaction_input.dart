class TransactionInput {
  double price;
  int quantity;
  String description;
  int productid;
  int? storeid;

  TransactionInput(this.price, this.quantity, this.description, this.productid,
      this.storeid);

  Map<String, dynamic> toJson() {
    return {
      "price": this.price,
      "qty": this.quantity,
      "description": this.description,
      "product_id": this.productid,
      "requester_store_ref": this.storeid
    };
  }
}

class TransactionInputAmend {
  double price;
  int quantity;
  String description;
  int transactionID;
  int requestID;

  TransactionInputAmend({
    required this.price,
    required this.quantity,
    required this.description,
    required this.transactionID,
    this.requestID = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "description": this.description,
      "price": this.price,
      "quantity": this.quantity,
      "tr_id": this.transactionID,
      "id": this.requestID,
      "request_id": this.requestID,
    };
  }
}
