import '../../libs.dart';

class SuperAdmin {
  User user;
  int registeredUsers;
  int registeredProducts;

  SuperAdmin(
      {required this.user,
      required this.registeredProducts,
      required this.registeredUsers});

  factory SuperAdmin.fromJson(json) {
    return SuperAdmin(
        user: User.fromJson(json),
        registeredProducts: json["registeredProducts"],
        registeredUsers: json["registeredUsers"]);
  }
}
