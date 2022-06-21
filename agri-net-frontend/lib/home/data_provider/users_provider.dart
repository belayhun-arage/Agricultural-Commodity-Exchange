import '../../libs.dart';
import "package:http/http.dart";
import "dart:convert";

class UsersProvider {
  Client client = Client();

  Future<UserResponse> getUserByID(int userid) async {
    try {
      final Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };
      var response = await client.get(
          Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/user/$userid",
          ),
          headers: headers);
      if (response.statusCode >= 100 && response.statusCode < 500) {
        final bosy = jsonDecode(response.body);
        print(bosy);
        return UserResponse.fromJson(bosy);
      } else {
        return UserResponse(
            statusCode: response.statusCode,
            msg: STATUS_CODES[response.statusCode] ?? "",
            user: null,
            role: "");
      }
    } catch (e, a) {
      print(e.toString());
      return UserResponse(
          statusCode: 999, msg: STATUS_CODES[999] ?? "", user: null, role: "");
    }
  }

  Future<UserResponse> getMerchantByStoreID(int storeID ) async {
    try {
      final Map<String, String> headers = {
        "authorization": StaticDataStore.HEADERS["authorization"]!
      };
      var response = await client.get(
          Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/store/merchant/$storeID",
          ),
          headers: headers);
      if (response.statusCode >= 100 && response.statusCode < 500) {
        final bosy = jsonDecode(response.body);
        print(bosy);
        return UserResponse.fromJson(bosy);
      } else {
        return UserResponse(
            statusCode: response.statusCode,
            msg: STATUS_CODES[response.statusCode] ?? "",
            user: null,
            role: "");
      }
    } catch (e, a) {
      print(e.toString());
      return UserResponse(
          statusCode: 999, msg: STATUS_CODES[999] ?? "", user: null, role: "");
    }
  }
}
