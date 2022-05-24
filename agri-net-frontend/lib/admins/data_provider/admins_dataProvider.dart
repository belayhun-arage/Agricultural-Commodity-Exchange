import 'dart:convert';
import 'package:http/http.dart';

import '../../libs.dart';

class AdminsProvider {
  static Client client = Client();
  AdminsProvider();

  Future<List<User>> getAdmins() async {
    final headers = {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"};
    List<User> usersList = [];
    var respo = await client.get(
        Uri(
          scheme: "http",
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          path: "/api/admins",
        ),
        headers: headers);
    if (respo.statusCode == 200) {
      List<dynamic> users = [];
      users = json.decode(respo.body);
      for (int i = 0; i < users.length; i++) {
        Map<String, dynamic> tempMap = users[i];
        usersList.add((User.fromJson(tempMap)));
      }
      return usersList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load admins');
    }
  }

  Future<AdminRegisterResponse> createNewUser(
    String firstname,
    String lastname,
    String email,
    String phone,
    String kebele,
    String woreda,
    String city,
    String unique_address,
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
              "unique_address": unique_address,
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
      return AdminRegisterResponse(
          statusCode: respo.statusCode,
          msg: body["msg"],
          user: User.fromJson(body["user"]),
          role: body["role"],
          address: Address.fromJson(body["address"]));
    }
    return AdminRegisterResponse(
        statusCode: respo.statusCode, msg: jsonDecode(respo.body)["msg"]);
  }

  Future<List<Merchant>> getMerchants() async {
    List<Merchant> merchantsLIst = [];
    var respo = await client.get(
        Uri(
          host: StaticDataStore.HOST,
          port: StaticDataStore.PORT,
          scheme: StaticDataStore.SCHEME,
          path: "/api/merchants",
        ),
        headers: {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"});

    if (respo.statusCode == 200 || respo.body == 201) {
      Map<String, dynamic> merchants = jsonDecode(respo.body);
      for (int i = 0; i < merchants.length; i++) {
        merchantsLIst.add(Merchant.fromJson(merchants[i]));
      }
      return merchantsLIst;
    } else {
      throw Exception("Error while retrieving merchants list");
    }
  }

  Future<List<Agent>> getAgents() async {
    List<Agent> agentList = [];
    var respo = await client.get(
        Uri(
            host: StaticDataStore.HOST,
            port: StaticDataStore.PORT,
            scheme: StaticDataStore.SCHEME,
            path: "/api/agents"),
        headers: {"Authorization": "Bearer ${StaticDataStore.USER_TOKEN}"});

    if (respo.statusCode == 200 || respo.statusCode == 201) {
      Map<String, dynamic> agents = jsonDecode(respo.body);
      for (int i = 0; i < agents.length; i++) {
        agentList.add(Agent.fromJson(agents[i]));
      }
      return agentList;
    } else {
      throw Exception("Erro while feching agents");
    }
  }
}
