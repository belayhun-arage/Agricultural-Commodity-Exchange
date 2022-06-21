class Transaction {
  int transactionId;
  double price;
  int quantity;
  int state;
  int deadline;
  String description;
  int productId;
  int requesterId;
  int requesterStoreRef;
  int sellerId;
  int sellerStoreRef;
  int createdAt;
  double kebdAmount;
  double guaranteeAmount;

  Transaction({
    required this.transactionId,
    required this.price,
    required this.quantity,
    required this.state,
    required this.deadline,
    required this.description,
    required this.productId,
    required this.requesterId,
    required this.requesterStoreRef,
    required this.sellerId,
    required this.sellerStoreRef,
    required this.createdAt,
    required this.kebdAmount,
    required this.guaranteeAmount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json["transaction_id"],
      price: double.parse("${json["price"]}"),
      quantity: json["quantity"],
      state: json["state"],
      deadline: json["deadline_ts"] ?? DateTime.now(),
      description: json["description"] ?? "",
      productId: json["product_id"],
      requesterId: json["requester_id"],
      requesterStoreRef: json["requester_store_ref"] ?? 0,
      sellerId: json["seller_id"] ?? 0,
      sellerStoreRef: json["seller_store_ref"] ?? 0,
      createdAt: json["created_at"],
      kebdAmount: double.parse("${json["kebd_amount"] ?? 0}"),
      guaranteeAmount: double.parse("${json["guarantee_amount"] ?? 0}"),
    );
  }
}
