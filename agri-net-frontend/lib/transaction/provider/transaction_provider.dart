import "package:http/http.dart";
import "../../libs.dart";
import "dart:convert";

class TransactionProvider {
  Client client = Client();

  Future<MyTransactionsResponse> getMyTransactions() async {
    try {
      final Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };
      var response = await client.get(
          Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/cxp/transactions",
          ),
          headers: headers);
      if (response.statusCode >= 100 && response.statusCode < 500) {
        final bosy = jsonDecode(response.body);
        return MyTransactionsResponse.fromJson(bosy);
      } else {
        return MyTransactionsResponse(
            statusCode: response.statusCode,
            msg: STATUS_CODES[response.statusCode] ?? "",
            transactions: []);
      }
    } catch (e, a) {
      print(e.toString());
      return MyTransactionsResponse(
          statusCode: 999, msg: STATUS_CODES[999] ?? "", transactions: []);
    }
  }

  Future<TransactionResponse> createTransaction(TransactionInput input) async {
    // try {
    final Map<String, String> headers = {
      "authorization": StaticDataStore.HEADERS["authorization"]!
    };
    var response = await client.post(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/merchant/transaction/new",
        ),
        body: jsonEncode(input.toJson()),
        headers: headers);
    print(
      response.statusCode,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final bosy = jsonDecode(response.body);
      return TransactionResponse.fromJson(bosy);
    } else {
      return TransactionResponse(
        statusCode: response.statusCode,
        msg:
            "${response.statusCode} ${STATUS_CODES[response.statusCode] ?? ""}",
        transaction: null,
      );
    }
    // } catch (e, a) {
    //   print(e.toString());
    //   return TransactionResponse(
    //       statusCode: 999, msg: STATUS_CODES[999] ?? "", transaction: null);
    // }
  }
}
