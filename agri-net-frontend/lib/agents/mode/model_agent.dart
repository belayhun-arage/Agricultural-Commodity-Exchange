import '../../libs.dart';

class Agent {
  User user;
  int storeCount;
  int postsCounte;
  int reg_by;
  Agent(
      {required this.user,
      required this.storeCount,
      required this.postsCounte,
      required this.reg_by});

  factory Agent.fromJson(json) {
    return Agent(
        user: json["user"],
        storeCount: json["store_count"],
        postsCounte: json["Posts_count"],
        reg_by: json["reg_by"]);
  }
}
