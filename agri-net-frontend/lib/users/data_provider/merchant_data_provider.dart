import 'dart:convert';

import 'package:http/http.dart';

import '../../libs.dart';

class MerchantProvider {
  static Client client = Client();
  MerchantProvider();

  Future<MerchantsResponse> getMerchants(int id) async {
    List<Merchant> merchantsLIst = [];
    // final user = StaticDataStore.USER_TOKEN.getUser();
    final queryParameters = {
      "created_by": id,
    }.map((key, value) => MapEntry(key, value.toString()));
    var respo = await client.get(
        Uri(
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            scheme: "http",
            path: "/api/merchants",
            queryParameters: queryParameters),
        headers: {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"});

    if (respo.statusCode == 200 || respo.body == 201) {
      Map<String, dynamic> merchants = jsonDecode(respo.body);
      return MerchantsResponse.fromJson(merchants);
    } else {
      throw Exception(respo.body);
    }
  }

  Future<UserRegisterResponse> createNewMerchant(
    String firstname,
    String lastname,
    String email,
    String phone,
    String kebele,
    String woreda,
    String city,
    String uniqueAddress,
    String region,
    String zone,
    double latitude,
    double longitude,
  ) async {
    final headers = {
      "Authorization": "Bearer ${StaticDataStore.USER_TOKEN}",
      "Content-Type": "application/json"
    };
    var respo = await client.post(
        Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/admin/merchant/new"),
        body: jsonEncode({
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          "phone": phone,
          "address": {
            "kebele": kebele,
            "woreda": woreda,
            "city": city,
            "unique_address": uniqueAddress,
            "region": region,
            "zone": zone,
            "latitude": latitude,
            "longitude": longitude
          }
        }),
        headers: headers);
    print(respo.body);
    if (respo.statusCode == 200 || respo.statusCode == 201) {
      var body = jsonDecode(respo.body) as Map<String, dynamic>;
      var newMerchant = body["merchant"];
      return UserRegisterResponse(
        user: Merchant.fromJson(body["merchant"]),
        statusCode: respo.statusCode,
        msg: body["msg"],
      );
    } else {
      return UserRegisterResponse(
          statusCode: respo.statusCode, msg: jsonDecode(respo.body)["msg"]);
    }
  }

  Future<DeleteUserResponse> deleteMerchant(int id) async {
    print(id);
    try {
      var respo = await client.delete(
          Uri(
              scheme: "http",
              host: StaticDataStore.HOST,
              port: StaticDataStore.PORT,
              path: "/api/admin/merchant/$id"),
          headers: {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"});
      print(respo.body);
      print(respo.statusCode);
      if (respo.statusCode == 200 || respo.statusCode == 201) {
        var json = jsonDecode(respo.body);
        return DeleteUserResponse.fromJson(json);
      } else {
        return DeleteUserResponse(
            statusCode: respo.statusCode,
            msg: STATUS_CODES[respo.statusCode] ?? "",
            errors: {});
      }
    } catch (e, a) {
      print("Cached");
      print(e);
      return DeleteUserResponse(
          statusCode: 999, msg: STATUS_CODES[999] ?? "", errors: {});
    }
  }
}
