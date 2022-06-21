import 'dart:convert';
import 'package:http/http.dart';

import '../../libs.dart';

class AdminProvider {
  static Client client = Client();
  AdminProvider();

  Future<AdminsResponse> getAdmins() async {
    try {
      final headers = {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"};
      var respo = await client.get(
          Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/admins",
            // queryParameters: {"offset": 0, "limit": 2}
          ),
          headers: headers);

      if (respo.statusCode == 200 || respo.statusCode == 201) {
        List<Map<String, dynamic>> admins =
            List<Map<String, dynamic>>.from(jsonDecode(respo.body));

        Map<String, dynamic> map = {
          "status_code": respo.statusCode,
          "msg": "admins found",
          "admins": admins
        };
        return AdminsResponse.fromJson(map);
      } else {
        return AdminsResponse(
            statusCode: respo.statusCode,
            msg: STATUS_CODES[respo.statusCode] ?? "",
            admins: []);
      }
    } catch (e, a) {
      return AdminsResponse(
          statusCode: 999, msg: STATUS_CODES[999] ?? "", admins: []);
    }
  }

  Future<UserRegisterResponse> createNewAdmin(
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
    print(firstname);
    print(email);
    final headers = {
      "Authorization": "Bearer ${StaticDataStore.USER_TOKEN}",
      "Content-Type": "application/json"
    };

    var respo = await client.post(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "api/superadmin/admin/new/",
        ),
        body: jsonEncode(
          {
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
          },
        ),
        headers: headers);

    print("This is the response body");
    print(respo.body);
    print("This is the response body");
    if (respo.statusCode == 200) {
      final body = jsonDecode(respo.body);
      return UserRegisterResponse(
          user: Admin.fromJson(body),
          statusCode: respo.statusCode,
          msg: body["msg"]);
    }
    return UserRegisterResponse(
        statusCode: respo.statusCode, msg: jsonDecode(respo.body)["msg"]);
  }
}
