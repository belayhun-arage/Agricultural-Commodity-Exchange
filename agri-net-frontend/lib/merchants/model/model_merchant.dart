import '../../libs.dart';

class Merchant {
  User user;
  int storeCount;
  int postsCounte;
  int reg_by;
  Merchant(
      {required this.user,
      required this.storeCount,
      required this.postsCounte,
      required this.reg_by});

  factory Merchant.fromJson(json) {
    return Merchant(
        user: json["user"],
        storeCount: json["store_count"],
        postsCounte: json["Posts_count"],
        reg_by: json["reg_by"]);
  }
}
