import '../../libs.dart';

class Agent extends User {
  // int storeCount;
  int postsCounte;
  int reg_by;
  Address address;
  Agent(Map<String, dynamic> json, this.postsCounte, this.reg_by, this.address)
      : super(
            id: json["id"] ?? 99999,
            firstname: json["firstname"] ?? "",
            lastname: json["lastname"] ?? "",
            email: json["email"] ?? '',
            phone: json["phone"] ?? "",
            imgurl: json["imgUrl"] ?? "",
            lang: json["lang"]);

  factory Agent.fromJson(json) {
    final agent = Agent(
        json,
        json["posts_count"],
        json["registered_by"],
        json["address"] != null
            ? Address.fromJson(json["address"])
            : Address(
                ID: 800,
                Kebele: "",
                City: "",
                Latitude: 0.0,
                Longitude: 0.0,
                Region: "",
                UniqueAddressName: "",
                Woreda: "",
                Zone: ""));
    return agent;
  }
}
