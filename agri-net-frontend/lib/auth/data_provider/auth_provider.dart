import 'dart:convert';

import "../../libs.dart";
import 'package:http/http.dart';

class AuthProvider {
  static Client client = Client();

  AuthProvider();

  Future<List<Map<String, dynamic>>?> loadMaids(int offset) async {
    final headers = {"Authorization": "Bearer ${StaticDataStore.TOKEN}"};
    print("Loading clients ");

    try {
      var response = await client.get(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/admins/",
        ),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body) as List<dynamic>;
        final map = body.map<Map<String, dynamic>>((elem) {
          return (elem as Map<String, dynamic>);
        }).toList();
        return map;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  

  Future<UsersLoginResponse> confirmUserByPhone(String phone  , String password) async {
   try {
      final input = {
        "phone": phone ,
        "password": password,
      };
      var response = await client.post(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/cxp/account/confirm",
        ),
        body: jsonEncode(input),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        StaticDataStore.HEADERS = response.headers;
        StaticDataStore.ROLE = body["role"];
        StaticDataStore.USER_TOKEN = body["token"];
        if (StaticDataStore.ROLE == ROLE_ADMIN) {
          return UsersLoginResponse(
              statusCode: response.statusCode,
              msg: body["msg"],
              user: Admin.fromJson(body["user"]),
              role: body["role"]);
        }
        if (StaticDataStore.ROLE == ROLE_MERCHANT) {
          return UsersLoginResponse(
              statusCode: response.statusCode,
              msg: body["msg"],
              user: Merchant.fromJson(body["user"]),
              role: body["role"]);
        }
        if (StaticDataStore.ROLE == ROLE_AGENT) {
          return UsersLoginResponse(
              statusCode: response.statusCode,
              msg: body["msg"],
              user: Agent.fromJson(body["User"]),
              role: body["role"]);
        }
        if (StaticDataStore.ROLE == ROLE_SUPERADMIN) {
          return UsersLoginResponse(
              statusCode: response.statusCode,
              msg: "${body["msg"]}",
              user: User.fromJson(body["user"] as Map<String, dynamic>),
              role: "${body["role"]}");
        } else {
          return UsersLoginResponse(
            statusCode: 500,
            msg: "Something went wrong",
          );
        }
      } else if (response.statusCode == 401 ||
          response.statusCode == 500 ||
          response.statusCode == 404) {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        return UsersLoginResponse(
          statusCode: response.statusCode,
          msg:
              "${(response.statusCode == 404) ? "invalid email/phone or password" : STATUS_CODES[response.statusCode] ?? "?"}",
        );
      } else {
        return UsersLoginResponse(
          statusCode: 999,
          msg: STATUS_CODES[999]!,
        );
      }
    } catch (e) {
      return UsersLoginResponse(
        statusCode: 999,
        msg: STATUS_CODES[999]!,
      );
    }
  }

  Future<UsersLoginResponse> loginAdmin(String email, String password) async {
    try {
      print("Sending login request with :" + "$email   $password");
      final input = {
        "email": StaticDataStore.isEmail(email) ? email : "",
        "phone": email.startsWith("+251") ? email : "",
        "password": password,
      };
      print(jsonEncode(input));
      var response = await client.post(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/login",
        ),
        body: jsonEncode(input),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        StaticDataStore.HEADERS = response.headers;
        StaticDataStore.ROLE = body["role"];
        StaticDataStore.USER_TOKEN = body["token"];
        if (StaticDataStore.ROLE == ROLE_ADMIN) {
          return UsersLoginResponse(
              statusCode: response.statusCode,
              msg: body["msg"],
              user: Admin.fromJson(body["user"]),
              role: body["role"]);
        }
        if (StaticDataStore.ROLE == ROLE_MERCHANT) {
          return UsersLoginResponse(
              statusCode: response.statusCode,
              msg: body["msg"],
              user: Merchant.fromJson(body["user"]),
              role: body["role"]);
        }
        if (StaticDataStore.ROLE == ROLE_AGENT) {
          return UsersLoginResponse(
              statusCode: response.statusCode,
              msg: body["msg"],
              user: Agent.fromJson(body["User"]),
              role: body["role"]);
        }
        if (StaticDataStore.ROLE == ROLE_SUPERADMIN) {
          return UsersLoginResponse(
              statusCode: response.statusCode,
              msg: "${body["msg"]}",
              user: User.fromJson(body["user"] as Map<String, dynamic>),
              role: "${body["role"]}");
        } else {
          return UsersLoginResponse(
            statusCode: 500,
            msg: "Something went wrong",
          );
        }
      } else if (response.statusCode == 401 ||
          response.statusCode == 500 ||
          response.statusCode == 404) {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        return UsersLoginResponse(
          statusCode: response.statusCode,
          msg:
              "${(response.statusCode == 404) ? "invalid email/phone or password" : STATUS_CODES[response.statusCode] ?? "?"}",
        );
      } else {
        return UsersLoginResponse(
          statusCode: 999,
          msg: STATUS_CODES[999]!,
        );
      }
    } catch (e) {
      return UsersLoginResponse(
        statusCode: 999,
        msg: STATUS_CODES[999]!,
      );
    }
  }

  Future<MessageOnly> forgotPassword(String email) async {
    try {
      var response = await client.get(
        Uri(
            scheme: "http",
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            path: "/api/password/forgot/?email=$email"),
      );
      print("${response.statusCode}   ${response.body}");
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return MessageOnly.fromJson(body, true);
      } else if (response.statusCode == 500) {
        return MessageOnly("Internal Problem", false);
      }
      return MessageOnly("Sorry,problem happened, try again", false);
    } catch (e) {
      return MessageOnly(
          "can't found the server \nplease check your internet connection",
          false);
    }
  }
}
