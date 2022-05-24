import 'dart:convert';

import "../../libs.dart";
import 'package:http/http.dart';

// import 'encoding/json';
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
    } catch (e, a) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> searchMaids(
      String text, int offset) async {
    final headers = {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"};
    try {
      var response = await client.get(
        Uri.parse(StaticDataStore.URI +
            "api/search/maids/?offset=$offset&limit=3&q=$text"),
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
    } catch (e, a) {
      print(a);
      return null;
    }
  }

  Future<UsersLoginResponse> loginAdmin(String email, String password) async {
    try {
      print("Sending login request with :" + "$email   $password");
      var response = await client.post(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/login",
        ),
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
        headers: {"Content-Type": "application/json"},
      );

      print(
          "You have the following response body ${response.body} and response status ${response.statusCode} DD:");
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body) as Map<String, dynamic>;

        StaticDataStore.HEADERS = response.headers;
        StaticDataStore.ROLE = body["role"];
        StaticDataStore.USER_TOKEN = body["token"];
        // Token = body["token"];
        return UsersLoginResponse(
            statusCode: response.statusCode,
            msg: "${body["msg"]}",
            user: User.fromJson(body["user"] as Map<String, dynamic>),
            role: "${body["role"]}");
      } else if (response.statusCode == 401 ||
          response.statusCode == 500 ||
          response.statusCode == 404) {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        return UsersLoginResponse(
          statusCode: response.statusCode,
          msg: "${body["message"]}",
        );
      } else {
        return UsersLoginResponse(
          statusCode: response.statusCode,
          msg: STATUS_CODES[999]!,
        );
      }
    } catch (e, a) {
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
    } catch (e, a) {
      return MessageOnly(
          "can't found the server \nplease check your internet connection",
          false);
    }
  }
}
