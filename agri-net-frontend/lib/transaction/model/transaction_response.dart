import "../../libs.dart";

class MyTransactionsResponse {
  List<Transaction> transactions;
  String msg;
  int statusCode;
  MyTransactionsResponse(
      {required this.statusCode,
      required this.msg,
      required this.transactions});

  factory MyTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return MyTransactionsResponse(
      statusCode: json["status_code"] ?? 999,
      msg: json["msg"],
      transactions: (json["transactions"] ?? []).map<Transaction>(
        (t) {
          return Transaction.fromJson(t);
        },
      ).toList(),
    );
  }
}

class TransactionResponse {
  int statusCode;
  String msg;
  Transaction? transaction;
  TransactionResponse(
      {required this.statusCode, required this.msg, required this.transaction});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      statusCode: json["status_code"] ?? 999,
      msg: json["msg"] ?? "internal issue",
      transaction: (json["transaction"]?? json["amendment_request"]) != null
          ? Transaction.fromJson(json["transaction"])
          : null,
    );
  }
}
