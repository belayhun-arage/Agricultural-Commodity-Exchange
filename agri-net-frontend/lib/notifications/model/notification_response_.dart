class GuaranteeNotification {
  int id;
  int state;
  int createdAt;
  int transactionID;
  String description;
  double amount;

  GuaranteeNotification({
    required this.id,
    required this.state,
    required this.createdAt,
    required this.transactionID,
    required this.description,
    required this.amount,
  });

  factory GuaranteeNotification.fromJson(Map<String, dynamic> json) {
    return GuaranteeNotification(
      id: json["id"] ?? 0,
      state: json["state"] ?? 0,
      createdAt: json["created_at"] ?? 0,
      transactionID: json["transaction_id"] ?? 0,
      description: json["description"] ?? "",
      amount: double.parse("${json["amount"]}"),
    );
  }
}

class TransactionRequest {
  int id;
  int state;
  int createdAt;
  int trId;
  String description;
  double price;
  int quantity;

  TransactionRequest(
      {required this.id,
      required this.state,
      required this.createdAt,
      required this.trId,
      required this.description,
      required this.price,
      required this.quantity});

  factory TransactionRequest.fromJson(Map<String, dynamic> json) {
    return TransactionRequest(
      id: json['id'] ?? 0,
      state: json['state'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      trId: json['tr_id'] ?? 0,
      description: json['description'] ?? "",
      price: double.parse("${json['price']}"),
      quantity: int.parse("${json['quantity']}"),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['tr_id'] = this.trId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}

class KebdRequest {
  int? id;
  int? state;
  int? createdAt;
  int? trId;
  int? kebdAmount;
  int? deadline;
  String? description;

  KebdRequest(
      {this.id,
      this.state,
      this.createdAt,
      this.trId,
      this.kebdAmount,
      this.deadline,
      this.description});

  factory KebdRequest.fromJson(Map<String, dynamic> json) {
    return KebdRequest(
      id: json['id'],
      state: json['state'],
      createdAt: json['created_at'],
      trId: json['tr_id'],
      kebdAmount: json['kebd_amount'],
      deadline: json['deadline'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['tr_id'] = this.trId;
    data['kebd_amount'] = this.kebdAmount;
    data['deadline'] = this.deadline;
    data['description'] = this.description;
    return data;
  }
}

class NotificationResponse {
  GuaranteeNotification? guaranteeNotification;
  TransactionRequest? transactionRequest;
  KebdRequest? kebdRequest;
  int transactionID;

  NotificationResponse({
    required this.guaranteeNotification,
    required this.transactionRequest,
    required this.kebdRequest,
    required this.transactionID,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      guaranteeNotification: json["guarantee_request"] != null
          ? GuaranteeNotification.fromJson(json["guarantee_request"])
          : null,
      transactionRequest: json["transaction_request"] != null
          ? TransactionRequest.fromJson(json["transaction_request"])
          : null,
      kebdRequest: json["kebd_request"] != null
          ? KebdRequest.fromJson(json["kebd_request"])
          : null,
      transactionID: json["tr_id"] ?? 0,
    );
  }
}

class TransactionNotifications {
  String msg;
  int statusCode;
  List<NotificationResponse> transactionNotifications;

  TransactionNotifications({
    required this.msg,
    required this.statusCode,
    required this.transactionNotifications,
  });

  factory TransactionNotifications.fromJson(Map<String, dynamic> json) {
    return TransactionNotifications(
        
        msg: json["msg"] ?? "",
        statusCode: json["status_code"] ?? 999,
        transactionNotifications: ((json["results"] ?? [])
                .map<Map<String, dynamic>>((e) {
          return e as Map<String, dynamic>;
        }).toList())
            .map<NotificationResponse>((e) => NotificationResponse.fromJson(e))
            .toList());
  }
}
