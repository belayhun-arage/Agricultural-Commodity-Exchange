import 'dart:convert';

import 'package:http/http.dart';
import '../../libs.dart';

class AgentProvider {
  static Client client = Client();
  AgentProvider();

  Future<AgentsResponse> getAgents(int id) async {
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
    if (respo.statusCode == 200 || respo.statusCode == 201) {
      Map<String, dynamic> agents = jsonDecode(respo.body);
      return AgentsResponse.fromJson(agents);
    } else {
      throw Exception("Error while feching agents");
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
