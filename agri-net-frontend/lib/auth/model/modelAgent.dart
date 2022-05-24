import '../../libs.dart';

class Agent {
  User user;
  Address address;
  int postCount;
  Agent({required this.user, required this.address, required this.postCount});

  factory Agent.fromJson(json) {
    return Agent(
        user: User.fromJson(json),
        address: Address.fromJson(json["address"]),
        postCount: json["posts_count"]);
  }
}
