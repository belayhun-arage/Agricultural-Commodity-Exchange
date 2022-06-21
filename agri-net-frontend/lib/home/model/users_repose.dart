import '../../libs.dart';

class UserResponse {
  int statusCode;
  String msg;
  User? user;
  String role;
  UserResponse(
      {required this.statusCode,
      required this.msg,
      required this.user,
      required this.role});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    String role = (json["role"] ?? "");
    return UserResponse(
        statusCode: int.parse("${json["status_code"] ?? 999}"),
        msg: json["msg"] ?? "",
        role: json["role"] ?? "",
        user: (role == ROLE_SUPERADMIN
            ? (SuperAdmin.fromJson(json["user"]) as User)
            : role == ROLE_ADMIN
                ? Admin.fromJson(json["user"])
                : (role == ROLE_MERCHANT
                    ? Merchant.fromJson(json["user"])
                    : (role == ROLE_AGENT
                        ? Agent.fromJson(json["user"])
                        : (role == ROLE_INFOADMIN
                            ? Admin.fromJson(json["user"])
                            : null))) ));
  }
}
