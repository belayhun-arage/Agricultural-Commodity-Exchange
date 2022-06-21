import "package:http/http.dart";
import "../../libs.dart";
import "dart:convert";

class NotificationProvider {
  Client client = Client();

  Future<TransactionNotifications> getMyTransactionNotifications() async {
    try {
      final Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };
      var response = await client.get(
          Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/cxp/mytransactions",
          ),
          headers: headers);
      if (response.statusCode >= 100 && response.statusCode < 500) {
        final bosy = jsonDecode(response.body);
        return TransactionNotifications.fromJson(bosy);
      } else {
        return TransactionNotifications(
            statusCode: response.statusCode,
            msg: STATUS_CODES[response.statusCode] ?? "",
            transactionNotifications: []);
      }
    } catch (e) {
      print(e.toString());
      return TransactionNotifications(
          statusCode: 999,
          msg: STATUS_CODES[999] ?? "",
          transactionNotifications: []);
    }
  }

  Future<SimpleResponse> declineTransaction(int transactionID) async {
    try {
      final Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };
      var response = await client.delete(
          Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/cxp/transaction/$transactionID",
          ),
          headers: headers);
          print(response.body);
          print(response.statusCode);
      if (response.statusCode >= 100 && response.statusCode < 500) {
        final bosy = jsonDecode(response.body);
        return SimpleResponse.fromJson(bosy);
      } else {
        return SimpleResponse(
          response.statusCode,
          STATUS_CODES[response.statusCode] ?? "",
        );
      }
    } catch (e) {
      print(e.toString());
      return SimpleResponse(
        999,
        STATUS_CODES[999] ?? "",
      );
    }
  }


  Future<TransactionResponse>  amendmentRequest(TransactionInputAmend input ) async {
    // try {
    final Map<String, String> headers = {
      "authorization": StaticDataStore.HEADERS["authorization"]!
    };
    var response = await client.post(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/cxp/transaction/amend",
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


  Future<TransactionResponse>  amendTheRequest(TransactionInputAmend input ) async {
    // try {
    final Map<String, String> headers = {
      "authorization": StaticDataStore.HEADERS["authorization"]!
    };
    var response = await client.post(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/merchant/transaction/request/ammend",
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


  Future<TransactionResponse>  acceptTransactionAmendment(int transactionRequestID) async {
    final Map<String, String> headers = {
      "authorization": StaticDataStore.HEADERS["authorization"]!
    };
    var response = await client.get(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/merchant/transaction/request/accept/$transactionRequestID",
        ),
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
  }



}
