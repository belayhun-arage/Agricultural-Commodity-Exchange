class PaymentNotification {
  int? id;
  int? state;
  int? createdAt;
  int? trId;
  int? sellerId;
  String? sellerInvoiceId;
  int? buyerId;
  String? buyerInvoiceId;
  int? kebdAmount;
  int? guaranteeAmount;
  bool? kebdCompleted;
  bool? guaranteeCompleted;
  int? serviceFee;

  PaymentNotification(
      {this.id,
      this.state,
      this.createdAt,
      this.trId,
      this.sellerId,
      this.sellerInvoiceId,
      this.buyerId,
      this.buyerInvoiceId,
      this.kebdAmount,
      this.guaranteeAmount,
      this.kebdCompleted,
      this.guaranteeCompleted,
      this.serviceFee});

  factory PaymentNotification.fromJson(Map<String, dynamic> json) {
    return PaymentNotification(
      id: json['id'],
      state: json['state'],
      createdAt: json['created_at'],
      trId: json['tr_id'],
      sellerId: json['seller_id'],
      sellerInvoiceId: json['seller_invoice_id'],
      buyerId: json['buyer_id'],
      buyerInvoiceId: json['buyer_invoice_id'],
      kebdAmount: json['kebd_amount'],
      guaranteeAmount: json['guarantee_amount'],
      kebdCompleted: json['kebd_completed'],
      guaranteeCompleted: json['guarantee_completed'],
      serviceFee: json['service_fee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'state': this.state,
      'created_at': this.createdAt,
      'tr_id': this.trId,
      'seller_id': this.sellerId,
      'seller_invoice_id': this.sellerInvoiceId,
      'buyer_id': this.buyerId,
      'buyer_invoice_id': this.buyerInvoiceId,
      'kebd_amount': this.kebdAmount,
      'guarantee_amount': this.guaranteeAmount,
      'kebd_completed': this.kebdCompleted,
      'guarantee_completed': this.guaranteeCompleted,
      'service_fee': this.serviceFee
    };
  }
}
