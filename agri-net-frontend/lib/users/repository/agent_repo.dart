import '../../libs.dart';

class AgentRepo {
  AgentProvider agentProvider;
  AgentRepo({required this.agentProvider});

  Future<AgentsResponse> getAgents(int id) async {
    return await agentProvider.getAgents(id);
  }

  Future<UserRegisterResponse> creatNewAgent(
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
    return await agentProvider.createNewAgent(firstname, lastname, email, phone,
        kebele, woreda, city, uniqueAddress, region, zone, latitude, longitude);
  }
}
