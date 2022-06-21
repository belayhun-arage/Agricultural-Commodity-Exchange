import 'dart:convert';
import 'package:http/http.dart';

import '../../libs.dart';

class UserProvider {
  static Client client = Client();
  UserProvider();

  Future<List<Admin>> getAdmins() async {
    final headers = {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"};
    List<Admin> adminsList = [];
    var respo = await client.get(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/admins",
          // queryParameters: {"offset": 0, "limit": 2}
        ),
        headers: headers);
    if (respo.statusCode == 200) {
      print(respo.body);
      List<dynamic> admins = json.decode(respo.body);
      for (int i = 0; i < admins.length; i++) {
        Map<String, dynamic> tempMap = admins[i] as Map<String, dynamic>;
        adminsList.add((Admin.fromJson(tempMap)));
      }
      return adminsList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load admins');
    }
  }

  Future<List<Merchant>> getMerchants(Admin admin) async {
    List<Merchant> merchantsLIst = [];
    // final user = StaticDataStore.USER_TOKEN.getUser();
    final queryParameters = {
      "created_by": admin.id,
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
      print("The Whole Response body \n\n");
      print(respo.body);
      Map<String, dynamic> merchants = jsonDecode(respo.body);
      print("decoding \n\n");
      print(merchants);
      var listOfMerchants = merchants["merchants"];
      print("Only merchants list\n\n");
      print(listOfMerchants);
      if (listOfMerchants.length > 0) {
        for (int i = 0; i < listOfMerchants.length; i++) {
          Map<String, dynamic> theMerchants =
              listOfMerchants[i] as Map<String, dynamic>;
          merchantsLIst.add(Merchant.fromJson(theMerchants));
        }
        print(merchantsLIst);
        return merchantsLIst;
      } else {
        print("\n \n Merchants not found");
        return merchantsLIst;
      }
    } else {
      throw Exception(respo.body);
    }
  }

  Future<List<Agent>> getAgents(int id) async {
    List<Agent> agentList = [];
    final queryParameters = {
      "created_by": "${id}",
    };
    var respo = await client.get(
        Uri(
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            scheme: "http",
            path: "/api/agents",
            queryParameters: queryParameters),
        headers: {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"});
    print(respo.body);
    print(respo.statusCode);

    if (respo.statusCode == 200 || respo.statusCode == 201) {
      Map<String, dynamic> agents = jsonDecode(respo.body);
      var listOfAgents = agents["agents"];
      for (int i = 0; i < listOfAgents.length; i++) {
        Map<String, dynamic> tempMap = listOfAgents[i] as Map<String, dynamic>;
        agentList.add(Agent.fromJson(tempMap));
      }
      return agentList;
    } else {
      throw Exception("Error while feching agents");
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
    print("\n\n\n\n\n");
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

  Future<UserRegisterResponse> createNewAgent(
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
            path: "/api/admin/agent/new"),
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
    print("\n\n\n\n\n");
    print(respo.body);
    if (respo.statusCode == 200 || respo.statusCode == 201) {
      var body = jsonDecode(respo.body) as Map<String, dynamic>;
      var newMerchant = body["agent"];
      return UserRegisterResponse(
        user: Agent.fromJson(body["agent"]),
        statusCode: respo.statusCode,
        msg: body["msg"],
      );
    } else {
      return UserRegisterResponse(
          statusCode: respo.statusCode, msg: jsonDecode(respo.body)["msg"]);
    }
  }
}
