import '../../libs.dart';

class Agent extends User {
  int storeCount;
  int postsCounte;
  int reg_by;
  Agent(
      Map<String, dynamic> json, this.storeCount, this.postsCounte, this.reg_by)
      : super(
            id: json["id"],
            firstname: json["firstname"],
            lastname: json["lastname"],
            email: json["email"],
            phone: json["phone"],
            imgurl: json["imgUrl"],
            lang: json["lang"]);

  factory Agent.fromJson(json) {
    return Agent(json, json["store_count"] ?? 0, json["Posts_count"] ?? 0,
        json["reg_by"] ?? 7);
  }
}
